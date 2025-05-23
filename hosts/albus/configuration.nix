{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./pkgs.nix
      ../../users/garulf.nix
      ./firewall.nix
      ../common/base.nix
      ../../services/sunshine.nix
      ../profiles/gaming.nix
      ../profiles/coding.nix
      ../../wm/x11/i3wm.nix
      ../../wm/x11/gnome.nix
      ../../wm/wayland/hyprland.nix
    ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  environment.systemPackages = with pkgs; [
     lm_sensors
     input-remapper
     cage
     weston
     gnome.nautilus
     streamdeck-ui
     playerctl
     pulseaudio
     hacompanion
     lua
     liquidctl
     coolercontrol.coolercontrol-gui
     inputs.nix-citizen.packages.${system}.star-citizen
  ];

  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = false;

  services.rpiplay.enable = true;


  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.unstable.linuxPackages_6_14;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/8977809b-02a7-4d4a-abc3-1233af23414c";
      preLVM = true;
    };
  };

  networking.hostName = "Albus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "gnome-remote-desktop";
  services.xrdp.openFirewall = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  services.flatpak.enable = false;

  programs.mosh.enable = true;

  programs.honkers-railway-launcher.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
