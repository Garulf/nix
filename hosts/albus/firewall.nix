{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 
    6742 # OpenRGB
    47990 # Sunshine admin
    47984 # Sunshine
    47989 # Sunshine
    47990 # Sunshine
    48010 # Sunshine
  ];
  networking.firewall.allowedUDPPorts = [ 
    { from = 47998; to = 48000; }
  ];

}

