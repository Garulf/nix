{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 
    6742 # OpenRGB
    47990 # Sunshine admin
    47984 # Sunshine
    47989 # Sunshine
    47990 # Sunshine
    48010 # Sunshine
    3389 # RDP
    5900 # VNC
    5901 # VNC
  ];
  networking.firewall.allowedUDPPortRanges = [ 
    { from = 47998; to = 48000; } # Sunshine
    { from = 60000; to = 61000; } # Mosh
  ];

}

