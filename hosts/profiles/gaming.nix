{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [ 
      ../../pkgs/steam.nix
      ../../pkgs/prismlauncher.nix
    ];
  
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  environment.systemPackages = with pkgs; [
     gzdoom
     gamemode
     gamescope
     lutris
     obs-studio
  ];

  programs.gamemode.enable = true;
}
