{ lib, config, pkgs, ... }: {
  imports = [

  ];

  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.grimblast
    hyprslurp
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland.override { wrapRuntimeDeps = false; };
    systemd = {
      enable = true;
      # Same as default, but stop graphical-session too
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

      
}