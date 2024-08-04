{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/neovim.nix
    # ../pkgs/discord.nix
  ];


  users.users.garulf = {
    isNormalUser = true;
    description = "Garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      entr
      helvum
      eww
      killall
      pipx
      discord
      ranger
      pavucontrol
      procps
      python3Full
      firefox
      cider
      qutebrowser
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
      gallery-dl # A command-line program to download image-galleries and -collections from several image hosting sites
      pika-backup # Simple backups based on borg
      github-desktop # A GitHub Desktop client
      jqp # A command-line JSON processor
      stow # A tool for managing the installation of multiple software packages in the same run-time directory tree
      xwinwrap # A utility that allows you to use an animated X window as the wallpaper
      tree
      bc
      yazi
      cmatrix
      vlock
      plexamp
      gimp-with-plugins
    ];
  };

  security.pam.services.garulf.enableGnomeKeyring = true;

  services.usbmuxd.enable = true;

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
