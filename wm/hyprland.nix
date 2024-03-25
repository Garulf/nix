{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    unstable.waybar
    kitty
    dunst
    libnotify
    swww
    unstable.hyprlock
    unstable.hypridle
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

  #security.pam.swaylock = {};

}
