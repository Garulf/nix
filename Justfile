default:
    @just --list

# Build and activate config, set as boot default
switch:
    #!/usr/bin/env bash
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin switch .
    else
        nh os switch .
    fi

# Build and set as boot default without activating (takes effect on next reboot)
boot:
    #!/usr/bin/env bash
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin build .
    else
        nh os boot .
    fi

# Build and activate config without setting as boot default
test:
    #!/usr/bin/env bash
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin switch . --dry
    else
        nh os test .
    fi

# Build without activating (useful for checking for errors)
build:
    #!/usr/bin/env bash
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin build .
    else
        nh os build .
    fi

# Update all flake inputs
update:
    nix flake update

# Update a single flake input: just update-input nixpkgs
update-input input:
    nix flake update {{input}}

# Remove old generations and collect garbage
gc:
    nh clean all
