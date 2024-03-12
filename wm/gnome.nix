{ pkgs, lib, ...}:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  
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
