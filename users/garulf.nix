{ config, pkgs, ... }: 

{
  imports = [
    ../wm/gnome.nix
    ../wm/i3wm.nixW
    # ../wm/hyprland.nix
    ../pkgs/discord.nix
  ];

  services.xserver.displayManager.defaultSession = "none+i3";

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
      bitwarden-cli
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
      jq
      xcolor
      feh
      maim
      xdotool
      cifs-utils
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
