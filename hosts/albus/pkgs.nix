{ config, pkgs, ... }:

{
  imports =
    [
      ../../pkgs/steam.nix
      ../../pkgs/openrgb.nix
      ../../pkgs/sunshine.nix
      ../../pkgs/rpiplay.nix
      ../../pkgs/virt.nix
      ../../pkgs/wine.nix
    ];
}

