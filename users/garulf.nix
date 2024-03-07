{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
  ];

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      discord
      cider
      bitwarden
      ulauncher
      google-chrome
      vscode
      screen
    ];
  };

}