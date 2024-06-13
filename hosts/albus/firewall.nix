{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 
    6742 # OpenRGB
    3389 # RDP
    5900 # VNC
    5901 # VNC
  ];
  networking.firewall.allowedUDPPortRanges = [ 
    { from = 60000; to = 61000; } # Mosh
  ];

}

