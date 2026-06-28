# NixOS Config Restructure

**Date:** 2026-06-28  
**Goal:** Make changes easy to find by grouping config by purpose; remove home-manager; replace neovim config with nixvim + LazyVim.

---

## Problem

The current layout mixes concerns across inconsistently-named directories (`pkgs/` contains modules not packages, `services/` and `wm/` are separate from `pkgs/` for no clear reason). Finding where to make a change requires knowing the history of how files were added, not the purpose of the change.

---

## Proposed Directory Structure

```
flake.nix
hosts/
  common/
    base.nix              # SSH, fonts, polkit — unchanged
  profiles/
    gaming.nix            # thick profile: steam, wine, prismlauncher, gamescope, gamemode, obs-studio
    coding.nix            # thick profile: nixvim (lazyvim + treesitter + lsp), vscode, python, gnumake
  albus/
    configuration.nix
    hardware-configuration.nix
    firewall.nix
    mdadm.nix
    gdm-monitors.nix
  argentum/
    configuration.nix
    hardware-configuration.nix
modules/
  hardware/
    nvidia.nix            # ← hosts/common/nvidia.nix
  desktop/
    hyprland.nix          # ← wm/wayland/hyprland.nix
    gnome.nix             # ← wm/x11/gnome.nix
    i3wm.nix              # ← wm/x11/i3wm.nix
  services/
    sunshine.nix          # ← services/sunshine.nix
    rpiplay.nix           # ← services/rpiplay.nix
    smb.nix               # ← hosts/albus/smb.nix
  programs/
    discord.nix           # ← pkgs/discord.nix
    mpv.nix               # ← pkgs/mpv.nix
    openrgb.nix           # ← pkgs/openrgb.nix
    virt.nix              # ← pkgs/virt.nix
    honkers.nix           # ← pkgs/honkers.nix
    brave.nix             # ← pkgs/browsers/brave.nix
    chrome.nix            # ← pkgs/browsers/chrome.nix
overlays/
  default.nix             # unchanged
users/
  garulf.nix              # absorbs zsh config from home/garulf/cli/zsh.nix
  ashley.nix
```

**Rule:** if you're configuring a program → `modules/programs/`; a background service → `modules/services/`; a desktop environment or compositor → `modules/desktop/`; GPU/hardware-specific → `modules/hardware/`; a cohesive workflow (gaming rig, dev machine) → `hosts/profiles/`.

---

## Profiles

Profiles are "thick" — they own all config for their domain inline, not spread across separate files.

**`profiles/gaming.nix`** includes inline:
- `programs.steam` (with `pkgs.unstable.steam`, remote play, dedicated server firewall)
- `hardware.steam-hardware.enable`
- `programs.gamescope` (with `pkgs.unstable.gamescope`)
- `programs.gamemode.enable`
- Wine (via `environment.systemPackages`)
- Prismlauncher
- obs-studio, mangohud, heroic, protonup, lutris, gzdoom

**`profiles/coding.nix`** includes inline:
- nixvim (see nixvim section below)
- vscode, python3Full, pipx, gnumake

---

## nixvim

Add flake input:
```nix
nixvim.url = "github:nix-community/nixvim/nixos-24.05";
nixvim.inputs.nixpkgs.follows = "nixpkgs";
```

Import `nixvim.nixosModules.nixvim` in both host module lists in `flake.nix`.

Configure in `profiles/coding.nix`:

```nix
programs.nixvim = {
  enable = true;
  defaultEditor = true;

  plugins.lazy = {
    enable = true;
    plugins = [
      { name = "LazyVim/LazyVim"; import = "lazyvim.plugins"; }
    ];
  };

  plugins.treesitter = {
    enable = true;
    settings.highlight.enable = true;
  };

  plugins.lsp = {
    enable = true;
    servers = {
      lua-ls.enable = true;
      nixd.enable = true;
      pyright.enable = true;
    };
  };

  plugins.mason.enable = false;
};
```

LSPs are provided by nixvim's nix-managed packages — Mason is disabled. Treesitter grammars are pre-compiled by nix via nixvim's treesitter plugin. Additional LSPs (rust-analyzer, clangd, ts-ls) can be added to `plugins.lsp.servers` as needed.

---

## Home-manager Removal

- Delete `home/` directory entirely.
- Remove `home-manager` input and `homeConfigurations` output from `flake.nix`.
- `home/garulf/cli/zsh.nix` is entirely commented out — nothing to migrate.
- Drop `home.stateVersion` — no NixOS equivalent needed.

---

## Files Deleted

| File | Reason |
|---|---|
| `home/` (entire dir) | home-manager removed |
| `pkgs/` (entire dir) | contents moved to `modules/programs/` or inlined into profiles |
| `services/` (entire dir) | contents moved to `modules/services/` |
| `wm/` (entire dir) | contents moved to `modules/desktop/` |
| `shells/python.nix` | never imported anywhere |
| `hosts/common/rdp.nix` | dead — albus configures xrdp inline in configuration.nix |
| `hosts/albus/pkgs.nix` | import aggregator — imports go directly into configuration.nix |
| `users/base.nix` | one-liner wrapper around garulf.nix |

---

## Import Path Updates

Every moved file gets updated import paths in all files that reference it. Host `configuration.nix` files import directly from `../../modules/...` paths. The `pkgs/` overlay additions reference (`import ../pkgs {pkgs = final;}` in `overlays/default.nix`) is removed since custom derivations are not in scope — the `additions` overlay entry is dropped.

---

## Fixes Bundled In

- Remove unused `sunshineOverride` let-binding in `modules/services/sunshine.nix`
- Remove duplicate `programs.neovim` blocks from `users/garulf.nix` and `hosts/argentum/configuration.nix` (nixvim replaces both)
- Remove duplicate `vim`/`git` from `hosts/argentum/configuration.nix` system packages (provided by `hosts/common/base.nix`)
