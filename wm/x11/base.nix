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
  ];

  # services.picom.enable = true;
  # systemd.user.services.picom.serviceConfig.ExecStart = ''
  #   ${pkgs.picom}/bin/picom --config /home/garulf/.config/picom/picom.conf
  # '';

}
