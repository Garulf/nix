{ pkgs, lib, ...}:

{
  imports = [
    ./base.nix
  ];

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      # i3status
      i3lock
      xss-lock
      i3blocks
      i3lock-fancy
      polybar
      xborders
      xidlehook
      imagemagick
    ];
  };

  environment.etc."systemd/system-sleep/openrgb.sh".source =
    pkgs.writeShellScript "openrgb.sh" ''
      if [ "$1" = "pre" ]; then
        ${pkgs.openrgb}/bin/openrgb -c 000000
      elif [ "$1" = "post" ]; then
        ${pkgs.openrgb}/bin/openrgb -c ffffff
      fi
    '';

}
