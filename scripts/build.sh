#!/usr/bin/env bash
# Copy each shared/<name>.md into the references/ folder of every skill whose
# SKILL.md names references/<name>.md, then zip the plugin for upload to claude.ai.
# Skills that name references/conventions.md also get writing.md.
#   scripts/build.sh          copy, then write dist/kitt-<version>.zip
#   scripts/build.sh --check  exit 1 if any copy is stale, missing or unwanted
set -euo pipefail
cd "$(dirname "$0")/.."

mode="${1:-build}"
stale=0
for skill in skills/*/; do
  for src in shared/*.md; do
    name="$(basename "$src")"
    dest="${skill}references/${name}"
    want=0
    grep -q "references/${name}" "$skill/SKILL.md" && want=1
    [ "$name" = writing.md ] && grep -q 'references/conventions.md' "$skill/SKILL.md" && want=1
    if [ "$mode" = "--check" ]; then
      if [ "$want" = 1 ]; then cmp -s "$src" "$dest" || { echo "stale: $dest"; stale=1; }
      elif [ -e "$dest" ]; then echo "unwanted: $dest"; stale=1; fi
    elif [ "$want" = 1 ]; then
      mkdir -p "${skill}references"
      cp "$src" "$dest"
    else
      rm -f "$dest"
    fi
  done
done
if [ "$mode" = "--check" ]; then exit "$stale"; fi

version="$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' .claude-plugin/plugin.json)"
mkdir -p dist
zip_path="dist/kitt-${version}.zip"
rm -f "$zip_path"
zip -qr "$zip_path" .claude-plugin skills README.md LICENSE NOTICE.md icon.png -x '*.DS_Store' -x '.claude-plugin/marketplace.json'
echo "$zip_path"
