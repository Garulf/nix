{ config, pkgs, ... }:

{
  import = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./pkgs.nix
    ../../users/garulf.nix
    ./firewall.nix
    ../common/base.nix
  ];
}
