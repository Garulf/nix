{ config, pkgs, ... }: 

{
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

  programs.zsh.enable = true;
  users.users.yourname.shell = pkgs.zsh;
}