#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e


# check for changes to config
# git ls-files -m | grep -qP '^.*\.nix$' || (echo "No changes to config detected!"; false)

# Autoformat your nix files
# alejandra . &>/dev/null

# Shows your changes
# git diff *.nix

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"


# clean up older generations
sudo nix-collect-garbage --delete-older-than 14d
sudo nix-store --gc
