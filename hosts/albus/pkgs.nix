{ config, pkgs, ... }:

{
  imports =
    [
      ../../pkgs/steam.nix
      ../../pkgs/openrgb.nix
      ../../pkgs/rpiplay.nix
      ../../pkgs/virt.nix
      ../../pkgs/wine.nix
      ../../pkgs/mpv.nix
    ];
}

