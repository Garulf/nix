{ pkgs, lib, ...}:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.windowManager.qtile.enable = false; 
  # services.xserver.windowManager.i3.enable = true;
  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      # i3status
      i3lock
      i3blocks
      feh
      picom
      xborders
      xidlehook
    ];
  };
  # services.picom.enable = true;
  # systemd.user.services.picom.serviceConfig.ExecStart = ''
  #   ${pkgs.picom}/bin/picom --config /home/garulf/.config/picom/picom.conf
  # '';

  programs.dconf.profiles = {
      # TODO: Investigate customizing gdm greeter.
      user.databases = [{
        settings = with lib.gvariant; {
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";

          "org/gnome/shell".enabled-extensions = [
            "forge@jmmaranan.com"
          ];

          "org/gnome/desktop/wm/keybindings" = {
            switch-to-workspace-1 = ["<Super>1"];
            switch-to-workspace-2 = ["<Super>2"];
            switch-to-workspace-3 = ["<Super>3"];
            switch-to-workspace-4 = ["<Super>4"];
          };
        };
      }];
    };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.forge
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.systemstatsplus
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.gamemode-indicator-in-system-settings
    gnome.gnome-remote-desktop
    gnomeExtensions.tophat
    gnome.gnome-boxes
    gtop
    libgtop
    ddcutil
  ];

  environment.variables = {
    GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };

  # Needed for ddcutil
  hardware.i2c.enable = true;
}
