{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../../hosts/profiles/coding.nix
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "aarch64-darwin";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "garulf" ];
  };

  services.nix-daemon.enable = true;

  users.users.garulf = {
    home = "/Users/garulf";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    just
    nh
    curl
    wget
    htop
    killall
    unzip
  ];

  programs.zsh.enable = true;

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv"; # column view
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false; # key repeat instead of accent picker
    };
  };

  networking.hostName = "Aurum";

  system.stateVersion = 5;
}
