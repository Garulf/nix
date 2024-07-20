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
     mangohud
  ];

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
    package = pkgs.unstable.gamescope;
  };
}
