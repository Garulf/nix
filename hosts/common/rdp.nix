{ pkgs, lib, ...}:

{
  services.xserver.enable = true;


  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "gnome-remote-desktop";
  services.xrdp.openFirewall = true;
}