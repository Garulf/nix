{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/base.nix
    ../profiles/gaming.nix
    ../profiles/coding.nix
    ../../users/garulf.nix
    ../../services/sunshine.nix
    # Albedo is Hyprland-only — no GNOME/i3 imports.
    ../../wm/wayland/hyprland.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ---- Bootloader ----
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # 2G ESP -> keep lots of generations around.
  boot.loader.systemd-boot.configurationLimit = 20;
  # Windows lives on a separate NVMe/ESP; pick it from the firmware boot menu.
  # (systemd-boot won't auto-detect a Windows loader on a different disk's ESP.)

  # ---- ZFS: encrypted mirror data pool `tank` ----
  # Unique 8 hex chars, REQUIRED for ZFS. Generate with:
  #   head -c4 /dev/urandom | od -A none -t x4
  networking.hostId = "REPLACE8";
  boot.supportedFilesystems = [ "zfs" "btrfs" "ntfs" ];
  # 25.05's default kernel is ZFS-compatible, so no explicit kernel pin is needed.
  # (The RTX 5080 driver from nvidia.nix also constrains the kernel; the default
  # works for both. If you ever pin a kernel, keep it within ZFS's supported range.)
  boot.zfs.extraPools = [ "tank" ];
  # We load the key from a file (below), not by prompting.
  boot.zfs.requestEncryptionCredentials = false;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = false; # spinning disks

  # After the encrypted root is up, load tank's key (kept on the encrypted root)
  # and let zfs-mount mount it. One boot-time unlock (USB/passphrase) covers this.
  systemd.services."zfs-load-key-tank" = {
    description = "Load ZFS encryption key for tank";
    after = [ "zfs-import-tank.service" ];
    requires = [ "zfs-import-tank.service" ];
    before = [ "zfs-mount.service" ];
    wantedBy = [ "zfs-mount.service" ];
    path = [ config.boot.zfs.package ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = "zfs load-key -a";
  };

  # ---- Cross-OS shared partition (NTFS) on the Windows NVMe ----
  # Label the partition "shared" in Windows; read/write from only one OS at a time.
  fileSystems."/mnt/shared" = {
    device = "/dev/disk/by-label/shared";
    fsType = "ntfs3";
    options = [ "nofail" "rw" "nosuid" "nodev" "relatime" "uid=1000" "gid=100" "iocharset=utf8" ];
  };

  # ---- Host identity / locale / networking ----
  networking.hostName = "Albedo";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # ---- Desktop: Hyprland-only (Wayland) ----
  # Hyprland itself comes from ../../wm/wayland/hyprland.nix (programs.hyprland,
  # xdg portal, NIXOS_OZONE_WL). No X server / display-manager desktop is needed.
  # Lean greeter: greetd + tuigreet launches Hyprland straight from a tty.
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };
  # Console keymap (there is no services.xserver.xkb without an X server).
  console.keyMap = "us";

  # ---- Audio (pipewire) ----
  services.pulseaudio.enable = false; # 25.05: renamed from hardware.pulseaudio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.printing.enable = true;

  # (Graphics stack is configured in ./nvidia.nix via hardware.graphics.)

  # ---- Fans / RGB / Star Citizen (Linux equivalents of the Windows apps) ----
  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;

  environment.systemPackages = with pkgs; [
    liquidctl
    coolercontrol.coolercontrol-gui
    lm_sensors
    playerctl
    inputs.nix-citizen.packages.${pkgs.system}.star-citizen
  ];

  system.stateVersion = "25.05"; # fresh install on the 25.05 channel
}
