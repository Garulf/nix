{ pkgs, lib, ...}:

{
  imports = [
    ./base.nix
  ];

  programs.dconf.enable = true;

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      # i3status
      i3lock-color
      xss-lock
      i3blocks
      xborders
      xidlehook
      imagemagick
      i3altlayout
      i3-wk-switch
      eww
      lxappearance
    ];
  };


  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
  ];
}
