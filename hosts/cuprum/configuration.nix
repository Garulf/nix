{ inputs, outputs, lib, config, pkgs, ... }:

let
  tz = "America/New_York";
  dataDir = "/opt/homeserver";
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
    colima       # lightweight Docker runtime, no Docker Desktop license needed
    docker
    docker-compose
    htop
    wget
    curl
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = false;
    # plex-media-server is a macOS-native binary; the nixpkgs package is Linux-only
    # and cannot access VideoToolbox for hardware transcoding
    casks = [ "plex-media-server" ];
  };

  environment.variables = {
    TZ = tz;
    HOMESERVER_DATA = dataDir;
  };

  # Colima (Linux VM + Docker daemon) — starts on login
  launchd.user.agents.colima = {
    serviceConfig = {
      Label = "com.abiosoft.colima";
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
        "--arch" "aarch64"
        "--vm-type" "vz"         # Apple Virtualization Framework (fast on M1)
        "--vz-rosetta"            # Rosetta 2 for x86_64 container images
        "--memory" "4"
        "--cpu" "4"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/colima.log";
      StandardErrorPath = "/tmp/colima.log";
    };
  };

  # Apple Silicon detector for Frigate — exposes NPU over ZMQ on port 5555.
  # The app bundle must be installed first:
  # https://github.com/frigate-nvr/apple-silicon-detector/releases
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
