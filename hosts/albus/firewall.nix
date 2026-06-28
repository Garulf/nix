{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    6742 # OpenRGB
    5900 # VNC
    5901 # VNC
    3000
    8080
  ];

}

