{ config, pkgs, ... }: 

{
  imports = [
    ../wm/x11/gnome.nix
    ../wm/x11/i3wm.nix
    ../wm/wayland/hyprland.nix
    ../pkgs/neovim.nix
    # ../pkgs/discord.nix
  ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.displayManager.defaultSession = "none+i3";

  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      killall
      pipx
      discord
      ranger
      pavucontrol
      procps
      python3Full
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
      obsidian
      remmina
      synology-drive-client
      neofetch
      zoxide
      tuba
      starship
      gcc
      gh
      wget
      jq
      feh
      maim
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
      pika-backup
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
