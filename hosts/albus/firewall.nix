{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 
    6742 # OpenRGB
    47990 # Sunshine
  ];

}

