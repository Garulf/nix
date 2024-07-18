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
     lutris
     obs-studio
  ];

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    package = pkgs.unstable.gamescope;
  };
}
