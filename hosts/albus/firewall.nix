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
    7000 # rpiplay 1
    7100 # rpiplay 2
  ];
  networking.firewall.allowedUDPPortRanges = [ 
    { from = 47998; to = 48000; } # Sunshine
    6000 # rpiplay 1
    6001 # rpiplay 2
    7011 # rpiplay 3
  ];

}

