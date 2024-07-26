{ config, pkgs, ... }: 

{
  imports = [
    ../wm/x11/gnome.nix
    ../wm/x11/i3wm.nix
    ../wm/wayland/hyprland.nix
    ../pkgs/neovim.nix
    # ../pkgs/discord.nix
  ];
  services.displayManager.defaultSession = "none+i3";

  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
    setupCommands = ''
      bash -c "/home/garulf/.screenlayout/default.sh"
    '';
  };


  users.users.garulf = {
    isNormalUser = true;
    description = "garulf";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "i2c" "power" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      entr
      mpris-notifier
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
      libimobiledevice # A library that talks the protocols to support iPhone, iPod Touch, iPad and Apple TV devices
      ifuse # A tool for mounting Apple devices
      stow # A tool for managing the installation of multiple software packages in the same run-time directory tree
      xwinwrap # A utility that allows you to use an animated X window as the wallpaper
      tree
      bc
      yazi
    ];
  };
  
  services.usbmuxd.enable = true;

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.pyright
    ];
  };

}
