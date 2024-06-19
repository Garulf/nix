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
      xdg-desktop-portal-gnome
      i3altlayout
      i3-wk-switch
    ];
  };
}
