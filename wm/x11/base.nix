{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    gnome.gnome-screenshot
    feh
    dunst
    picom
  ];

  # services.picom.enable = true;
  # systemd.user.services.picom.serviceConfig.ExecStart = ''
  #   ${pkgs.picom}/bin/picom --config /home/garulf/.config/picom/picom.conf
  # '';

}
