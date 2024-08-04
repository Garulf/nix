{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    gnome.gnome-screenshot
    dex
    feh
    dunst
    picom
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    arandr
    xclip
    xcolor
    xdotool
    wmctrl
    xdg-desktop-portal-gtk
    xorg.xrandr
    xorg.xset
    xorg.xkill
    libadwaita
  ];

  services.xserver = {
    enable = true;
    desktopManager.wallpaper = {
      combineScreens = true;
      mode = "fill";
    };
  };

  services.gnome.gnome-keyring.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # services.picom.enable = true;
  # systemd.user.services.picom.serviceConfig.ExecStart = ''
  #   ${pkgs.picom}/bin/picom --config /home/garulf/.config/picom/picom.conf
  # '';

}
