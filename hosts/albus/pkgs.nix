{ config, pkgs, ... }:

{
  imports =
    [
      ../../pkgs/steam.nix
      # ../../pkgs/openrgb.nix
      ../../services/rpiplay.nix
      ../../pkgs/virt.nix
      ../../pkgs/wine.nix
      ../../pkgs/mpv.nix
    ];

    services.hardware.openrgb.enable = true;
}

