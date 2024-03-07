# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.preLVMCommands = ''
    mdadm --assemble /dev/md0
  '';

  systemd.services.raid-monitor = {
    description = "Mdadm Raid Monitor";
    wantedBy = [ "multi-user.target" ];
    after = [ "postfix.service" ];
    serviceConfig.ExecStart = "${pkgs.mdadm}/bin/mdadm --monitor --scan";
  };

  environment.etc."mdadm.conf".text = ''
    MAILADDR root
    ARRAY /dev/md0 level=raid5 num-devices=4 metadata=1.2 name=albus:0 UUID=7673361d:6833b71b:2069f66f:ed297107
      devices=/dev/sda1,/dev/sdb1,/dev/sdc1,/dev/sdd1
  '';


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06295bb5-da42-4852-9a8f-eb9f2656e4d8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/00BA-B843";
      fsType = "vfat";
    };

  fileSystems."/mnt/Games M.2" =
    { device = "/dev/disk/by-uuid/BC96451A9644D694";
      fsType = "ntfs-3g";
      options = ["x-gvfs-show" "rw" "nosuid" "exec" "user" "nodev" "relatime" "nofail" "uid=1000" "gid=100" "iocharset=utf8" "uhelper=udisks2"];
    };

  fileSystems."/mnt/Storage" =
    { device = "/dev/md0";
      fsType = "ext4";
      options = ["nosuid" "user" "nodev" "nofail" "x-gvfs-show" "rw" "exec"];
      label = "Storage";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
