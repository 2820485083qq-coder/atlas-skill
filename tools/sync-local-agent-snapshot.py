#!/usr/bin/env python3
"""Refresh the Codex and shared-agent snapshot in this repository.

The script copies installed Skill directories, the Codex global instructions,
and user-defined Codex agent profiles. It deliberately excludes bundled runtime
content, cache/build output, credential-named files, and the host-specific
Codex config.toml.
"""

from __future__ import annotations

import json
import os
import re
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
PROFILE = Path(os.environ["USERPROFILE"]).resolve()
CODEX_SKILLS = PROFILE / ".codex" / "skills"
AGENT_SKILLS = PROFILE / ".agents" / "skills"
CODEX_INSTRUCTIONS = PROFILE / ".codex" / "AGENTS.md"
CUSTOM_AGENTS = PROFILE / ".codex" / "agents"

EXCLUDED_TOP_LEVEL = {".system", "codex-primary-runtime"}
EXCLUDED_DIRS = {
    ".git",
    ".system",
    ".cache",
    "__pycache__",
    ".pytest_cache",
    ".mypy_cache",
    ".ruff_cache",
    "node_modules",
    "dist",
    "build",
    ".venv",
    "venv",
}
EXCLUDED_FILE_NAME = re.compile(
    r"(?:^\.env(?:\..*)?$|secret|token|credential|api[_-]?key|private[_-]?key|\.(?:pem|p12|pfx)$)",
    re.IGNORECASE,
)
MAX_FILE_BYTES = 95 * 1024 * 1024


def ensure_repo_child(path: Path) -> None:
    resolved = path.resolve(strict=False)
    if not resolved.is_relative_to(REPO_ROOT):
        raise RuntimeError(f"Refusing to write outside repository: {path}")
    if path.is_symlink():
        raise RuntimeError(f"Refusing to replace a symlink in repository: {path}")


def reset_repo_directory(relative: str) -> Path:
    target = REPO_ROOT / relative
    ensure_repo_child(target)
    if target.exists():
        shutil.rmtree(target)
    target.mkdir(parents=True, exist_ok=True)
    return target


def excluded(relative: Path) -> bool:
    if any(part.lower() in EXCLUDED_DIRS for part in relative.parts[:-1]):
        return True
    return bool(EXCLUDED_FILE_NAME.search(relative.name))


def copy_skill_root(source_root: Path, root_name: str, destination: Path) -> tuple[int, int, list[dict]]:
    if not source_root.is_dir():
        raise FileNotFoundError(f"Skill root does not exist: {source_root}")

    copied_files = 0
    skipped_files = 0
    entries: list[dict] = []
    for source_dir in sorted(source_root.iterdir(), key=lambda p: p.name.casefold()):
        if not source_dir.is_dir():
            continue
        if root_name == "codex" and source_dir.name in EXCLUDED_TOP_LEVEL:
            continue

        resolved_source = source_dir.resolve(strict=True)
        if not resolved_source.is_dir():
            continue
        dest_skill = destination / source_dir.name
        ensure_repo_child(dest_skill)
        dest_skill.mkdir(parents=True, exist_ok=True)
        skill_md = resolved_source / "SKILL.md"
        entries.append(
            {
                "root": root_name,
                "directory": source_dir.name,
                "skill_name": source_dir.name,
                "has_skill_md": skill_md.is_file(),
                "description": description_from_skill(skill_md) if skill_md.is_file() else None,
            }
        )

        for source_file in resolved_source.rglob("*"):
            if source_file.is_symlink() or not source_file.is_file():
                continue
            relative = source_file.relative_to(resolved_source)
            if excluded(relative) or source_file.stat().st_size > MAX_FILE_BYTES:
                skipped_files += 1
                continue
            target = dest_skill / relative
            ensure_repo_child(target)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source_file, target)
            copied_files += 1

    return copied_files, skipped_files, entries


def description_from_skill(path: Path) -> str | None:
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        return None
    end = next((i for i in range(1, len(lines)) if lines[i].strip() == "---"), None)
    if end is None:
        return None
    frontmatter = lines[1:end]
    start = next((i for i, line in enumerate(frontmatter) if re.match(r"^description\s*:", line)), None)
    if start is None:
        return None

    first = re.sub(r"^description\s*:\s*", "", frontmatter[start]).strip()
    values: list[str] = []
    if first and first not in {"|", ">", "|-", ">-", "|+", ">+"}:
        values.append(first)
    else:
        for line in frontmatter[start + 1 :]:
            if line and not line[0].isspace():
                break
            value = line.strip()
            if value:
                values.append(value)
    description = " ".join(values).strip().strip("'\"")
    if len(description) > 400:
        description = description[:397].rstrip() + "..."
    return description or None


def copy_setting(source: Path, relative: str) -> None:
    if not source.is_file():
        raise FileNotFoundError(f"Expected settings file is missing: {source.name}")
    if EXCLUDED_FILE_NAME.search(source.name):
        raise RuntimeError(f"Settings file name matches a secret exclusion: {source.name}")
    target = REPO_ROOT / relative
    ensure_repo_child(target)
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, target)


def update_readme() -> None:
    readme = REPO_ROOT / "README.md"
    marker = "## 本机 Skills 与 Agent 设置快照"
    existing = readme.read_text(encoding="utf-8") if readme.exists() else ""
    if marker in existing:
        existing = existing[: existing.index(marker)].rstrip() + "\n\n"
    section = f"""{marker}

- `skills/codex/`：来自 `%USERPROFILE%\\.codex\\skills` 的本机 Codex Skills。
- `skills/agents/`：来自 `%USERPROFILE%\\.agents\\skills` 的共享 Agent Skills。
- `memory/codex/AGENTS.md`：Codex 全局指令。
- `agents/codex/`：用户自定义 Codex Agent 配置。

系统内置 `.system`、`codex-primary-runtime`、缓存/构建产物和凭据类文件会被排除。主机专属的 `.codex/config.toml` 不属于此快照；它包含项目绑定和 MCP 运行配置。

在 Windows 上刷新快照：

```powershell
python .\\tools\\sync-local-agent-snapshot.py
```
"""
    readme.write_text(existing + section, encoding="utf-8", newline="\n")


def main() -> None:
    manifest_path = REPO_ROOT / "manifest.json"
    old_manifest = json.loads(manifest_path.read_text(encoding="utf-8")) if manifest_path.exists() else []
    manifest = [item for item in old_manifest if item.get("root") not in {"codex", "agents"}]

    codex_dest = reset_repo_directory("skills/codex")
    agents_dest = reset_repo_directory("skills/agents")
    reset_repo_directory("memory/codex")
    reset_repo_directory("agents/codex")

    codex_count, codex_skipped, codex_entries = copy_skill_root(CODEX_SKILLS, "codex", codex_dest)
    agents_count, agents_skipped, agents_entries = copy_skill_root(AGENT_SKILLS, "agents", agents_dest)
    copy_setting(CODEX_INSTRUCTIONS, "memory/codex/AGENTS.md")
    for agent_file in sorted(CUSTOM_AGENTS.iterdir(), key=lambda p: p.name.casefold()):
        if agent_file.is_file() and agent_file.suffix.lower() == ".toml":
            copy_setting(agent_file, f"agents/codex/{agent_file.name}")

    manifest.extend(codex_entries)
    manifest.extend(agents_entries)
    manifest.sort(key=lambda item: (item.get("root", ""), item.get("directory", "").casefold()))
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    update_readme()

    print(f"codex_directories={len(codex_entries)} codex_files={codex_count}")
    print(f"agent_directories={len(agents_entries)} agent_files={agents_count}")
    print(f"filtered_files={codex_skipped + agents_skipped}")
    print(f"agent_profiles={sum(1 for p in (REPO_ROOT / 'agents/codex').glob('*.toml'))}")
    print("snapshot_refresh=complete")


if __name__ == "__main__":
    main()
