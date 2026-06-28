#!/usr/bin/env bash
set -uo pipefail

cd "$(dirname "$0")"

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch --flake . --impure 2>&1 | tee /tmp/nixos-switch.log
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    echo "Rebuild failed! See /tmp/nixos-switch.log for details."
    exit 1
fi

current=$(nixos-rebuild list-generations | grep current)
generation=$(echo "$current" | cut -d ' ' -f 1)

git add -u
if ! git commit -m "$current"; then
    echo "Nothing to commit."
fi

nixos_version=$(echo "$current" | awk '{print $5}' | cut -d'.' -f1-2)
host=$(hostname -s | tr '[:upper:]' '[:lower:]')
tag="v${nixos_version}-${host}-gen.${generation}"

if git tag -a "$tag" -m "$current" 2>/dev/null; then
    git push --follow-tags
    echo "Tagged as $tag"
else
    echo "Warning: tag $tag already exists, skipping tag."
    git push
fi

echo "Rebuild generation $generation complete!"
