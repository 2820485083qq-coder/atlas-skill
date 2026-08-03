#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
target="${HOME}/.codex"
apply=0
force=0
merge_routing=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [--target PATH] [--apply] [--force] [--merge-routing]

Plan the installation of the public Codex package. The default is a dry run and
does not modify PATH. Pass --apply to copy the public payload into PATH.
Pass --force only when intentional replacement of conflicting package files is
acceptable. Pass --merge-routing to append the marked public workflow fragment
to PATH/AGENTS.md with a timestamped backup when that file already exists.

Only these package paths are installed:
  skills/codex          -> PATH/skills
  config/codex/agents   -> PATH/agents (when present)
  tools/codex/bin       -> PATH/bin
  tools/codex/docs      -> PATH/docs

The full archive snapshot at memory/codex/AGENTS.md is never installed. Only
profiles/codex/AGENTS.fragment.md can be merged explicitly.
EOF
}

while (($#)); do
  case "$1" in
    --target)
      (($# >= 2)) || { printf '%s\n' 'error: --target requires a path' >&2; exit 2; }
      target="$2"
      shift 2
      ;;
    --apply)
      apply=1
      shift
      ;;
    --force)
      force=1
      shift
      ;;
    --merge-routing)
      merge_routing=1
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

[[ -n "$target" ]] || { printf '%s\n' 'error: target must not be empty' >&2; exit 2; }

payload=(
  "skills/codex:$target/skills"
  "tools/codex/bin:$target/bin"
  "tools/codex/docs:$target/docs"
)
if [[ -d "$script_dir/config/codex/agents" ]]; then
  payload+=("config/codex/agents:$target/agents")
fi

printf 'Codex public package target: %s\n' "$target"
printf '%s\n' 'Managed paths (existing unrelated files are preserved):'
for item in "${payload[@]}"; do
  printf '  %s -> %s\n' "${item%%:*}" "${item#*:}"
done
printf '%s\n' 'The full AGENTS.md snapshot is never overwritten; only the marked routing fragment can be merged explicitly.'
if (( merge_routing )); then
  printf '%s\n' 'Routing fragment: profiles/codex/AGENTS.fragment.md -> target/AGENTS.md (explicit merge requested)'
fi

if (( ! apply )); then
  printf '%s\n' 'Plan only. Re-run with --apply to perform the copy.'
  exit 0
fi

bash "$script_dir/scripts/check-public.sh"

check_tree_conflicts() {
  for item in "${payload[@]}"; do
    source="$script_dir/${item%%:*}"
    destination="${item#*:}"
    [[ -d "$source" ]] || { printf 'error: missing package directory: %s\n' "$source" >&2; exit 1; }
    if [[ -L "$destination" ]]; then
      printf 'error: refusing symlink destination: %s\n' "$destination" >&2
      exit 1
    fi
    if [[ -d "$destination" ]] && find "$destination" -type l -print -quit | grep -q .; then
      printf 'error: refusing destination tree containing symlinks: %s\n' "$destination" >&2
      exit 1
    fi
    if (( ! force )); then
      while IFS= read -r -d '' source_file; do
        relative="${source_file#"$source"/}"
        destination_file="$destination/$relative"
        if [[ -e "$destination_file" ]] && ! cmp -s "$source_file" "$destination_file"; then
          printf 'error: conflicting destination file (use --force intentionally): %s\n' "$destination_file" >&2
          exit 1
        fi
      done < <(find "$source" -type f -print0)
    fi
  done
}

check_routing_conflicts() {
  (( merge_routing )) || return 0
  destination="$target/AGENTS.md"
  if [[ -L "$destination" ]]; then
    printf 'error: refusing symlink AGENTS.md: %s\n' "$destination" >&2
    exit 1
  fi
  if [[ -e "$destination" ]] && grep -q '<!-- atlas-skill:begin -->' "$destination"; then
    if ! grep -q '<!-- atlas-skill:end -->' "$destination"; then
      printf '%s\n' 'error: AGENTS.md contains a malformed atlas-skill block without an end marker; repair it manually before retrying.' >&2
      exit 1
    fi
    if (( ! force )); then
      printf '%s\n' 'error: AGENTS.md already contains an atlas-skill block; use --force to refresh it with a backup.' >&2
      exit 1
    fi
  fi
}

if [[ -L "$target" ]]; then
  printf 'error: refusing symlink target: %s\n' "$target" >&2
  exit 1
fi
check_tree_conflicts
check_routing_conflicts
mkdir -p -- "$target"

copy_tree() {
  local source="$1"
  local destination="$2"

  [[ -d "$source" ]] || { printf 'error: missing package directory: %s\n' "$source" >&2; exit 1; }
  if [[ -L "$destination" ]]; then
    printf 'error: refusing symlink destination: %s\n' "$destination" >&2
    exit 1
  fi
  mkdir -p -- "$destination"
  cp -R -- "$source"/. "$destination"/
}

for item in "${payload[@]}"; do
  copy_tree "$script_dir/${item%%:*}" "${item#*:}"
done

if (( merge_routing )); then
  fragment="$script_dir/profiles/codex/AGENTS.fragment.md"
  destination="$target/AGENTS.md"
  [[ -f "$fragment" ]] || { printf 'error: missing routing fragment: %s\n' "$fragment" >&2; exit 1; }
  if [[ -L "$destination" ]]; then
    printf 'error: refusing symlink AGENTS.md: %s\n' "$destination" >&2
    exit 1
  elif [[ ! -e "$destination" ]]; then
    cp -- "$fragment" "$destination"
  elif grep -q '<!-- atlas-skill:begin -->' "$destination"; then
    if (( force )); then
      backup="$destination.atlas-skill-backup-$(date +%Y%m%d%H%M%S)"
      cp -- "$destination" "$backup"
      awk '
        /<!-- atlas-skill:begin -->/ {skip=1; next}
        /<!-- atlas-skill:end -->/ {skip=0; next}
        !skip {print}
      ' "$destination" > "$destination.tmp"
      cat "$fragment" >> "$destination.tmp"
      mv -- "$destination.tmp" "$destination"
    else
      printf '%s\n' 'error: AGENTS.md already contains an atlas-skill block; use --force to refresh it with a backup.' >&2
      exit 1
    fi
  else
    backup="$destination.atlas-skill-backup-$(date +%Y%m%d%H%M%S)"
    cp -- "$destination" "$backup"
    printf '\n' >> "$destination"
    cat "$fragment" >> "$destination"
    printf 'Merged routing fragment; backup: %s\n' "$backup"
  fi
fi

printf '%s\n' 'Installed public Codex package. Existing files outside the managed paths were not removed.'
