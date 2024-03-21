{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    kitty
    dunst
    libnotify
    swww
    rofi-wayland
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags or [] ++ [
        "-Dexperimental=true"
      ];
    }))
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}