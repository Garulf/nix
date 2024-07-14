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
      wayland = false;
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
      gallery-dl
      pika-backup
      github-desktop
      jqp
      libimobiledevice
      ifuse
      discocss
    ];
  };
  
  services.usbmuxd.enable = true;

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
