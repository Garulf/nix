{ config, pkgs, ... }: 

{
  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      discord
    ];
  };

  programs.zsh.enable = true;
  users.users.yourname.shell = pkgs.zsh;
}