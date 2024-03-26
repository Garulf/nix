{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
    ../wm/hyprland.nix
    ../pkgs/discord.nix
  ];

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      python3
      firefox
      cider
      bitwarden
      ulauncher
      google-chrome
      vscode
      screen
      tmux
      kitty
      neovim
      obsidian
      remmina
      synology-drive-client
      neofetch
      zoxide
      tuba
      xclip
      starship
      gcc
      gh
      wget
    ];
  };

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.xserver.windowManager.dwm.enable = false;
  services.xserver.windowManager.i3.enable = false;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # for obsidian
  ];

}
