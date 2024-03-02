{ config, pkgs, ... }: 

{
  imports = [
    ../pkgs/browsers/brave.nix
  ];

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      discord
    ];
  };

  home-manager.users.misterio = import ../home/garulf/${config.networking.hostName}.nix;
}