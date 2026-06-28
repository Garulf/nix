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

  # Mount Albus SMB shares for Plex — waits for the host to be reachable,
  # then mounts. Credentials are read from macOS Keychain (add once with
  # `open smb://garulf@albus.local` and tick "Remember in Keychain").
  mount-smb = pkgs.writeShellScript "mount-smb-shares" ''
    until /sbin/ping -c1 -t2 albus.local &>/dev/null 2>&1; do
      sleep 10
    done

    /bin/mkdir -p /Volumes/Storage /Volumes/Media

    /sbin/mount_smbfs //garulf@albus.local/public  /Volumes/Storage 2>/dev/null || true
    /sbin/mount_smbfs //garulf@albus.local/private /Volumes/Media   2>/dev/null || true
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

  # SMB shares from Albus — mounted at boot for Plex media access
  launchd.daemons.mount-smb = {
    serviceConfig = {
      Label = "local.mount-smb-shares";
      ProgramArguments = [ "${mount-smb}" ];
      RunAtLoad = true;
      # Retry every 5 minutes in case the network drops
      StartInterval = 300;
      StandardOutPath = "/tmp/mount-smb.log";
      StandardErrorPath = "/tmp/mount-smb.log";
    };
  };

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
