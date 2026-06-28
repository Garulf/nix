default:
    @just --list

# Build and activate config, set as boot default
switch:
    nh os switch .

# Build and set as boot default without activating (takes effect on next reboot)
boot:
    nh os boot .

# Build and activate config without setting as boot default
test:
    nh os test .

# Build without activating (useful for checking for errors)
build:
    nh os build .

# Update all flake inputs
update:
    nix flake update

# Update a single flake input: just update-input nixpkgs
update-input input:
    nix flake update {{input}}

# Remove old generations and collect garbage
gc:
    nh clean all
