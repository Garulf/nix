{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
    ../pkgs/discord.nix
  ];

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      cider
      bitwarden
      ulauncher
      google-chrome
      vscode
      screen
      discord
      obsidian
    ];
  };

}