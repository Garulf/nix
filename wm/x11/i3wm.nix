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
      i3lock
      xss-lock
      i3blocks
      i3lock-fancy
      xborders
      xidlehook
      imagemagick
      i3altlayout
      i3-wk-switch
    ];
  };


  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
  ];
}
