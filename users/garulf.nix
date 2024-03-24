{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
    # ../wm/hyprland.nix
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
    ];
  };

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  with import <nixpkgs> {};
  neovim.override {
    withPython3 = true;
    extraPython3Packages = p: with p; [ unicode ... ];
  }

  services.xserver.windowManager.dwm.enable = false;
  services.xserver.windowManager.i3.enable = false;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # for obsidian
  ];

}
