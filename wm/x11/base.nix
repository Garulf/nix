{ pkgs, lib, ...}:

{
  # Enable the GNOME desktop environment.
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-screenshot
    feh
    dunst
    picom
    gnome.adwaita-icon-theme
  ];

  # services.picom.enable = true;
  # systemd.user.services.picom.serviceConfig.ExecStart = ''
  #   ${pkgs.picom}/bin/picom --config /home/garulf/.config/picom/picom.conf
  # '';

}
