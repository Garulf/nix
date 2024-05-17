{ config, pkgs, ... }: 

{
  imports = [
    ../wm/x11/gnome.nix
    ../wm/x11/i3wm.nix
    # ../wm/hyprland.nix
    # ../pkgs/discord.nix
  ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.displayManager.defaultSession = "none+i3";

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      ranger
      pavucontrol
      procps
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
      rofi
      fzf
      xxh
      trash-cli
      libnotify
      yt-dlp
      pocket-casts
      vlc
      gallery-dl
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
