{ inputs, outputs, lib, config, pkgs, ... }:

let
  tz = "America/New_York";
  dataDir = "/opt/homeserver";

  # Home Assistant Core — pkgs.home-assistant is Linux-only; manage a Python
  # venv at /opt/homeassistant so the macOS binary can reach Bluetooth.
  ha-start = pkgs.writeShellScript "home-assistant-start" ''
    set -e
    VENV="/opt/homeassistant"
    CONFIG="${dataDir}/home-assistant"

    if [ ! -f "$VENV/bin/hass" ]; then
      echo "First run: creating Home Assistant virtualenv..."
      ${pkgs.python312}/bin/python -m venv "$VENV"
      "$VENV/bin/pip" install --quiet --upgrade pip wheel
      "$VENV/bin/pip" install --quiet homeassistant
    fi

    exec "$VENV/bin/hass" --config "$CONFIG"
  '';

in {
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "garulf" ];
  };

  services.nix-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    git
    just
    nh
    colima
    docker
    docker-compose
    python312   # runtime for Home Assistant venv
    htop
    wget
    curl
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = false;
    casks = [ "plex-media-server" ];
  };

  environment.variables = {
    TZ = tz;
    HOMESERVER_DATA = dataDir;
  };

  # Colima (Linux VM + Docker daemon)
  launchd.user.agents.colima = {
    serviceConfig = {
      Label = "com.abiosoft.colima";
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
        "--arch" "aarch64"
        "--vm-type" "vz"
        "--vz-rosetta"
        "--memory" "4"
        "--cpu" "4"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/colima.log";
      StandardErrorPath = "/tmp/colima.log";
    };
  };

  # Home Assistant Core — native macOS, full Bluetooth access
  launchd.user.agents.home-assistant = {
    serviceConfig = {
      Label = "io.home-assistant.core";
      ProgramArguments = [ "${ha-start}" ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/home-assistant.log";
      StandardErrorPath = "/tmp/home-assistant.log";
    };
  };

  # SMB shares from Albus via autofs — mounts on demand, unmounts when idle.
  # Credentials stored in macOS Keychain (authenticate once via Finder).
  environment.etc."auto_smb".text = ''
    video  -fstype=smbfs,noowners,soft,nosuid,rw  ://garulf@10.0.0.2/video
    music  -fstype=smbfs,noowners,soft,nosuid,rw  ://garulf@10.0.0.2/music
  '';

  # Preserve macOS defaults and append our map mountpoints
  environment.etc."auto_master".text = ''
    +auto_master
    /net             -hosts          -nobrowse,hidefromfinder,nosuid
    /home            auto_home       -nobrowse,hidefromfinder
    /Network/Servers -fstab
    /-               -static
    /System/Volumes/Data/NAS  auto_smb
    /System/Volumes/Data/mnt  auto_smb
  '';

  # Apple Silicon detector for Frigate — exposes NPU over ZMQ on port 5555.
  # Install from: https://github.com/frigate-nvr/apple-silicon-detector/releases
  launchd.user.agents.frigate-detector = {
    serviceConfig = {
      Label = "nvr.frigate.apple-silicon-detector";
      ProgramArguments = [
        "/Applications/FrigateDetector.app/Contents/MacOS/FrigateDetector"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/frigate-detector.log";
      StandardErrorPath = "/tmp/frigate-detector.log";
    };
  };

  users.users.garulf = {
    home = "/Users/garulf";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  networking.hostName = "Cuprum";

  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
  };

  system.stateVersion = 5;
}
