#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "$script_dir/.." && pwd -P)"
scan_root="$repo_root"

if [[ $# -gt 0 ]]; then
  [[ $# -eq 2 && "$1" == "--root" ]] || { printf '%s\n' 'Usage: scripts/check-public.sh [--root PATH]' >&2; exit 2; }
  scan_root="$(cd -- "$2" && pwd -P)"
  repo_root="$scan_root"
fi
payload=(
  skills/codex
  skills/agents
  skills/claude
  skills/openclaw
  config/codex
  tools/codex
  profiles/codex
  memory/codex
  scripts
  docs
  README.md
  .gitignore
  install.sh
  manifest.json
)

failures=0

report() {
  printf 'public-package check: %s\n' "$*" >&2
  failures=1
}

for relative in "${payload[@]}"; do
  source_path="$repo_root/$relative"
  [[ -d "$source_path" || -f "$source_path" ]] || { report "missing required package path: $relative"; continue; }

  while IFS= read -r -d '' link_path; do
    report "symlink is not allowed: ${link_path#$repo_root/}"
  done < <(find "$source_path" -type l -print0)

  while IFS= read -r -d '' file_path; do
    file_name="${file_path##*/}"
    lower_name="$(printf '%s' "$file_name" | tr '[:upper:]' '[:lower:]')"
    case "$lower_name" in
      .env|.env.*|secret|secret.*|secrets.*|token|token.*|credential|credential.*|credentials.*|apikey|apikey.*|api_key|api_key.*|private-key*|private_key*|*.pem|*.p12|*.pfx|*.key|id_rsa|id_dsa|id_ecdsa|id_ed25519|user-config.json|user-config.local.json)
        report "sensitive filename is not allowed: ${file_path#$repo_root/}"
        ;;
    esac

    # These patterns identify private-key blocks, known token formats, or a
    # long literal assigned to a sensitive field. They intentionally do not
    # match environment-variable names, runtime environment reads, documented
    # placeholders, or public URLs.
    has_secret=0
    while IFS= read -r matched_line; do
      lower_line="$(printf '%s' "$matched_line" | tr '[:upper:]' '[:lower:]')"
      case "$lower_line" in
        *placeholder*|*example*|*dummy*|*fake*|*test*|*your[_-]*|*'<'*|*'${'* ) ;;
        *) has_secret=1; break ;;
      esac
    done < <(LC_ALL=C grep -EI \
      '(-----BEGIN([[:space:]][A-Z0-9_-]+){0,3}[[:space:]]PRIVATE[[:space:]]KEY-----|(^|[^A-Za-z0-9])sk-(proj-)?[A-Za-z0-9_-]{30,}|(^|[^A-Za-z0-9])gh[pousr]_[A-Za-z0-9_]{20,}|(^|[^A-Za-z0-9])github_pat_[A-Za-z0-9_]{20,}|(^|[^A-Za-z0-9])AKIA[0-9A-Z]{16}|(^|[^A-Za-z0-9])AIza[0-9A-Za-z_-]{20,}|^[[:space:]]*(export[[:space:]]+)?["'"'']?(api[_-]?key|secret|token|password|authorization)["'"'']?[[:space:]]*[:=][[:space:]]*["'"''][A-Za-z0-9_./+=-]{16,}["'"''][[:space:]]*(#.*)?$)' \
      "$file_path" || true)
    if (( has_secret )); then
      report "possible real secret in: ${file_path#$repo_root/}"
    fi

    if LC_ALL=C grep -nE '(^|[[:space:]])/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" >/dev/null \
      || LC_ALL=C grep -nE '`/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" >/dev/null \
      || LC_ALL=C grep -nE '"/(Users|home)/[A-Za-z0-9._-]+/' "$file_path" >/dev/null; then
      report "user absolute path is not allowed: ${file_path#$repo_root/}"
    fi
  done < <(find "$source_path" -type f -print0)
done

if (( failures )); then
  printf '%s\n' 'public-package check failed; no files were changed.' >&2
  exit 1
fi

printf '%s\n' 'public-package check passed.'
