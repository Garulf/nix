{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [ 
      ../../pkgs/steam.nix
      ../../services/prismlauncher.nix
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
}
