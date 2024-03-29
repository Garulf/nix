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
      i3blocks
      xborders
      xidlehook
    ];
  };
}
