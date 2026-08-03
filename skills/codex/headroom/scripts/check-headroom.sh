#!/bin/sh
set -eu

printf 'headroom='
if command -v headroom >/dev/null 2>&1; then
  command -v headroom
  headroom --version 2>&1 | head -1
else
  printf 'not-installed\n'
fi

printf 'python='
if command -v python3 >/dev/null 2>&1; then
  python3 --version 2>&1
else
  printf 'not-found\n'
fi

printf 'uv='
if command -v uv >/dev/null 2>&1; then
  uv --version 2>&1
else
  printf 'not-found\n'
fi

printf 'codex-paths=\n'
type -a codex 2>/dev/null || true

if command -v codex >/dev/null 2>&1; then
  printf 'codex-version='
  codex --version 2>&1 | head -1
fi

if [ -x /Applications/Codex.app/Contents/Resources/codex ]; then
  printf 'bundled-codex-version='
  /Applications/Codex.app/Contents/Resources/codex --version 2>&1 | head -1
fi

printf 'port-8787='
if lsof -nP -iTCP:8787 -sTCP:LISTEN >/dev/null 2>&1; then
  printf 'in-use\n'
else
  printf 'available\n'
fi

codex_home=${CODEX_HOME:-"$HOME/.codex"}
config_file="$codex_home/config.toml"
printf 'codex-home=%s\n' "$codex_home"
printf 'headroom-markers='
if [ -f "$config_file" ] && grep -q 'Headroom' "$config_file"; then
  printf 'present\n'
else
  printf 'absent\n'
fi

