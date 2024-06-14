{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     nodejs_18
     prismlauncher
     gamemode
     gamescope
     jdk17_headless
     jdk8_headless
  ];
}
