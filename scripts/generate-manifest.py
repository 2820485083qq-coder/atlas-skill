#!/usr/bin/env python3
"""Generate a deterministic inventory for the public Atlas Skill package."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
OUTPUT = REPO_ROOT / "manifest.json"
SKILL_ROOTS = ("skills/agents", "skills/claude", "skills/codex", "skills/openclaw")
PACKAGE_GROUPS = (
    ("config", "codex/agents", "config/codex/agents", "~/.codex/agents", True),
    ("tools", "codex", "tools/codex", "~/.codex/{bin,docs}", True),
    ("profiles", "codex", "profiles/codex", "~/.codex/AGENTS.md (optional)", True),
    ("memory", "codex", "memory/codex", "archive-only", False),
    ("scripts", "package", "scripts", "repository-only", False),
    ("docs", "package", "docs", "repository-only", False),
)
ROOT_FILES = (".gitignore", "README.md", "install.sh")
EXCLUDED_NAMES = {
    ".env",
    "auth.json",
    "manifest.json",
    "user-config.json",
    "user-config.local.json",
}
EXCLUDED_SUFFIXES = (
    ".jsonl",
    ".sqlite",
    ".sqlite-shm",
    ".sqlite-wal",
    ".db",
    ".db-shm",
    ".db-wal",
    ".pyc",
    ".pyo",
)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def public_files(base: Path) -> list[Path]:
    if not base.exists():
        return []
    if base.is_file():
        candidates = [base]
    else:
        candidates = list(base.rglob("*"))
    return sorted(
        (
            path
            for path in candidates
            if path.is_file()
            and not path.is_symlink()
            and "__pycache__" not in path.parts
            and path.name not in EXCLUDED_NAMES
            and not path.name.startswith(".env.")
            and not path.name.lower().endswith(EXCLUDED_SUFFIXES)
        ),
        key=lambda path: path.as_posix(),
    )


def frontmatter(skill_file: Path) -> tuple[str | None, str | None]:
    text = skill_file.read_text(encoding="utf-8", errors="replace")
    if not text.startswith("---"):
        return None, None
    block = text.split("---", 2)
    if len(block) < 3:
        return None, None
    name = re.search(r"^name:\s*[\"']?([^\"'\n]+)", block[1], re.MULTILINE)
    description = re.search(r"^description:\s*[\"']?(.+?)[\"']?\s*$", block[1], re.MULTILINE)
    return (name.group(1).strip() if name else None, description.group(1).strip() if description else None)


def file_records(paths: list[Path]) -> list[dict[str, str]]:
    return [
        {
            "path": path.relative_to(REPO_ROOT).as_posix(),
            "sha256": sha256(path),
        }
        for path in paths
    ]


def skill_inventory(root: str) -> list[dict[str, object]]:
    root_path = REPO_ROOT / root
    if not root_path.is_dir():
        return []

    entries: list[dict[str, object]] = []
    for directory in sorted((path for path in root_path.iterdir() if path.is_dir()), key=lambda path: path.name):
        if any(path.is_symlink() for path in directory.rglob("*")):
            raise SystemExit(f"symlink is not allowed in package: {directory}")
        skill_file = directory / "SKILL.md"
        skill_name, description = frontmatter(skill_file) if skill_file.is_file() else (None, None)
        files = file_records(public_files(directory))
        codex_skill = root == "skills/codex"
        entries.append(
            {
                "root": root.removeprefix("skills/").split("/", 1)[0],
                "directory": directory.name,
                "skill_name": skill_name or directory.name,
                "has_skill_md": skill_file.is_file(),
                "description": description,
                "installable": codex_skill,
                "install_target": f"~/.codex/skills/{directory.name}" if codex_skill else "archive-only",
                "file_count": len(files),
                "license_files": [
                    item["path"]
                    for item in files
                    if Path(item["path"]).name.lower().startswith("license")
                ],
                "files": files,
            }
        )
    return entries


def package_inventory() -> list[dict[str, object]]:
    entries: list[dict[str, object]] = []
    for root, directory, relative, target, installable in PACKAGE_GROUPS:
        files = file_records(public_files(REPO_ROOT / relative))
        entries.append(
            {
                "root": root,
                "directory": directory,
                "skill_name": None,
                "has_skill_md": False,
                "description": "Public package support files",
                "installable": installable,
                "install_target": target,
                "file_count": len(files),
                "license_files": [],
                "files": files,
            }
        )
    root_paths = [REPO_ROOT / path for path in ROOT_FILES if (REPO_ROOT / path).is_file()]
    files = file_records(root_paths)
    entries.append(
        {
            "root": "package",
            "directory": "root-files",
            "skill_name": None,
            "has_skill_md": False,
            "description": "Public package metadata and entrypoints",
            "installable": False,
            "install_target": "repository-only",
            "file_count": len(files),
            "license_files": [],
            "files": files,
        }
    )
    return entries


def main() -> None:
    entries = [entry for root in SKILL_ROOTS for entry in skill_inventory(root)]
    entries.extend(package_inventory())
    OUTPUT.write_text(json.dumps(entries, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    file_count = sum(int(entry["file_count"]) for entry in entries)
    print(f"wrote {len(entries)} entries and {file_count} files to {OUTPUT}")


if __name__ == "__main__":
    main()
