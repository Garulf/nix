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

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-4</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1440</x>
            <y>625</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>HDMI-0</connector>
              <vendor>HEC</vendor>
              <product>6Series58</product>
              <serial>0x0000119b</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-0</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1440</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-4</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-1</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1440</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>HDMI-1</connector>
              <vendor>HEC</vendor>
              <product>6Series58</product>
              <serial>0x0000119b</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <logicalmonitor>
            <x>1440</x>
            <y>527</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-0</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-4</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>4000</x>
            <y>223</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>HDMI-0</connector>
                <vendor>HEC</vendor>
                <product>6Series58</product>
                <serial>0x0000119b</serial>
              </monitorspec>
              <mode>
                <width>3840</width>
                <height>2160</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-0</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1440</x>
            <y>578</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-4</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>HDMI-0</connector>
              <vendor>HEC</vendor>
              <product>6Series58</product>
              <serial>0x0000119b</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTNH78367</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1440</x>
            <y>587</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>GSM</vendor>
                <product>27GL850</product>
                <serial>006NTCZ26251</serial>
              </monitorspec>
              <mode>
                <width>2560</width>
                <height>1440</height>
                <rate>144.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>HDMI-1</connector>
              <vendor>HEC</vendor>
              <product>6Series58</product>
              <serial>0x0000119b</serial>
            </monitorspec>
          </disabled>
        </configuration>
      </monitors>
    ''}"
  ];

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
    ];
  };
  
  services.usbmuxd.enable = true;

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
