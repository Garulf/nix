{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
   # ../wm/swaywm.nix
    ../pkgs/discord.nix
  ];

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      cider
      bitwarden
      ulauncher
      google-chrome
      vscode
      screen
      tmux
      neovim
      discord
      obsidian
      remmina
      synology-drive-client
    ];
  };

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # for obsidian
  ];

}
