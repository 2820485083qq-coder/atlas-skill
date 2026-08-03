#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "$script_dir/.." && pwd -P)"
source_root="${CODEX_HOME:-$HOME/.codex}"
apply=0

usage() {
  cat <<'EOF'
Usage: ./scripts/sync-codex.sh [--source PATH] [--apply]

Synchronize public files from a local Codex home into this repository. The
default is a dry run. The sync is additive: it skips symlinks and private
state, and never deletes repository-only skills.
EOF
}

while (($#)); do
  case "$1" in
    --source)
      (($# >= 2)) || { printf '%s\n' 'error: --source requires a path' >&2; exit 2; }
      source_root="$2"
      shift 2
      ;;
    --apply)
      apply=1
      shift
      ;;
    --dry-run|--plan)
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      printf 'error: unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

source_root="$(cd -- "$source_root" && pwd -P)"
[[ -f "$source_root/AGENTS.md" ]] || { printf 'error: missing source AGENTS.md: %s\n' "$source_root/AGENTS.md" >&2; exit 1; }
[[ "$source_root" != "$repo_root" ]] || { printf '%s\n' 'error: source must not be the repository itself' >&2; exit 1; }

printf 'Codex source: %s\n' "$source_root"
printf 'Repository target: %s\n' "$repo_root"
printf '%s\n' 'Public exclusions: .system, symlinks, local user-config files, auth/state databases, logs, sessions and secret-like filenames.'

if (( ! apply )); then
  printf '%s\n' 'Plan only. Re-run with --apply to synchronize files.'
  exit 0
fi

command -v rsync >/dev/null 2>&1 || { printf '%s\n' 'error: rsync is required for safe file-list synchronization' >&2; exit 1; }

source_public_preflight() {
  local failures=0
  local file_path
  while IFS= read -r -d '' file_path; do
    file_name="${file_path##*/}"
    lower_name="$(printf '%s' "$file_name" | tr '[:upper:]' '[:lower:]')"
    case "$lower_name" in
      .env|.env.*|*secret*|*credential*|token|token.*|*.token|*.token.*|*apikey*|*api_key*|*.pem|*.p12|*.pfx|*.key|auth.json|user-config.json|user-config.local.json|*.sqlite|*.sqlite-*|*.db|*.db-*|*.jsonl)
        # These are deliberately excluded from the public snapshot.
        continue
        ;;
    esac
    if LC_ALL=C grep -Iq . "$file_path" && {
      LC_ALL=C grep -qE '(^|[[:space:]])/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" \
        || LC_ALL=C grep -qE '`/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" \
        || LC_ALL=C grep -qE '"/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" \
        || LC_ALL=C grep -qE -- '-----BEGIN([[:space:]][A-Z0-9_-]+){0,3}[[:space:]]PRIVATE[[:space:]]KEY-----|(^|[^A-Za-z0-9])sk-(proj-)?[A-Za-z0-9_-]{30,}|(^|[^A-Za-z0-9])gh[pousr]_[A-Za-z0-9_]{20,}|(^|[^A-Za-z0-9])github_pat_[A-Za-z0-9_]{20,}|(^|[^A-Za-z0-9])AKIA[0-9A-Z]{16}|(^|[^A-Za-z0-9])AIza[0-9A-Za-z_-]{20,}' "$file_path"
    }; then
      printf 'error: source file needs manual publicization before sync: %s\n' "$file_path" >&2
      failures=1
    fi
  done < <(find "$source_root/skills" "$source_root/agents" "$source_root/bin" "$source_root/docs" -type f -print0 2>/dev/null)
  if LC_ALL=C grep -qE '(^|[[:space:]])/(Users|home)/[A-Za-z0-9._-]+/|`/(Users|home)/[A-Za-z0-9._-]+/|"/(Users|home)/[A-Za-z0-9._-]+/' "$source_root/AGENTS.md"; then
    printf 'error: source AGENTS.md contains a user absolute path: %s\n' "$source_root/AGENTS.md" >&2
    failures=1
  fi
  (( failures == 0 )) || {
    printf '%s\n' 'source preflight failed; nothing was synchronized.' >&2
    exit 1
  }
}

source_public_preflight

stage_root="$(mktemp -d)"
trap 'rm -rf "$stage_root"' EXIT
rsync -a --exclude '.git/' "$repo_root/" "$stage_root/"

sync_files() {
  local source_dir="$1"
  local destination_dir="$2"
  [[ -d "$source_dir" ]] || return 0
  mkdir -p -- "$destination_dir"
  (
    cd -- "$source_dir"
    find . -type f \
      ! -path './.system/*' \
      ! -name 'user-config.json' \
      ! -name 'user-config.local.json' \
      ! -path '*/__pycache__/*' \
      ! -name '*.pyc' \
      ! -name '*.jsonl' \
      ! -name '*.sqlite' \
      ! -name '*.sqlite-*' \
      ! -name '*.db' \
      ! -name '*.db-*' \
      ! -iname '*secret*' \
      ! -iname '*credential*' \
      ! -iname '*.pem' \
      ! -iname '*.p12' \
      ! -iname '*.pfx' \
      -print0
  ) | rsync -a --from0 --files-from=- "$source_dir/" "$destination_dir/"
}

sync_files "$source_root/skills" "$stage_root/skills/codex"
sync_files "$source_root/agents" "$stage_root/config/codex/agents"
sync_files "$source_root/bin" "$stage_root/tools/codex/bin"
sync_files "$source_root/docs" "$stage_root/tools/codex/docs"
cp -- "$source_root/AGENTS.md" "$stage_root/memory/codex/AGENTS.md"

if command -v python3 >/dev/null 2>&1; then
  python3 "$stage_root/scripts/generate-manifest.py"
else
  printf '%s\n' 'warning: python3 unavailable; manifest.json was not regenerated.' >&2
fi

bash "$repo_root/scripts/check-public.sh" --root "$stage_root"
rsync -a --exclude '.git/' "$stage_root/" "$repo_root/"
printf '%s\n' 'Codex public snapshot synchronized from a validated staging copy. Review git diff before committing.'
