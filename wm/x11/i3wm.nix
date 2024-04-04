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
      i3lock-fancy-unstable
      polybar
      xborders
      xidlehook
      imagemagick
    ];
  };
}
