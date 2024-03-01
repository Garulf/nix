{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.gnomeExtensions.forge
    pkgs.google-chrome
  ];
}

