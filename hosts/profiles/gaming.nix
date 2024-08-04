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
     obs-studio
     mangohud
     heroic
     protonup
    (lutris.override {
      extraLibraries = pkgs: [
        libadwaita
        gtk4
      ];
      extraPkgs = pkgs: [
        libadwaita
      ];
    })
  ];

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
    package = pkgs.unstable.gamescope;
  };
}
