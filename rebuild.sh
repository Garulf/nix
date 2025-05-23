#!/usr/bin/env bash
# A rebuild script that commits on a successful build



# check for changes to config
# git ls-files -m | grep -qP '^.*\.nix$' || (echo "No changes to config detected!"; false)

# Autoformat your nix files
# alejandra . &>/dev/null

# Shows your changes
# git diff *.nix

echo "NixOS Rebuilding..."

start_gen="$(nixos-rebuild list-generations | grep current | cut -d ' ' -f 1)"
# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake . --impure 2>&1 | tee nixos-switch.log 
# exit if there are errors

end_gen="$(nixos-rebuild list-generations | grep current | cut -d ' ' -f 1)"

if [ $start_gen -eq $end_gen ]; then
    echo "Rebuild failed!"
    exit 1
fi


# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)
generation=$(echo $current | cut -d ' ' -f 1)
# Commit all changes witih the generation metadata
git commit -am "$current"


version="$(git describe --tags --abbrev=0)"
nextversion=${version%.*}.$((${version##*.}+1))

git tag -a "$nextversion" -m "$current"

# clean up older generations
# sudo nix-collect-garbage --delete-older-than 14d
# sudo nix-store --gc

git push --follow-tags

echo "Upgraded from $version to $nextversion"
echo "Rebuild generation $generation complete!"
