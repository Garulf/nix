# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ./mdadm.nix
      ../common/nvidia.nix
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" "amd_iommu=on" "vfio-pci" ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06295bb5-da42-4852-9a8f-eb9f2656e4d8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/00BA-B843";
      fsType = "vfat";
    };

  fileSystems."/mnt/Games" =
    { device = "/dev/nvme1n1p1";
      fsType = "ext4";
      options = ["defaults" "user" "x-gvfs-show"];
    };

  fileSystems."/mnt/Storage" =
    { device = "uuid=";
      fsType = "ext4";
      options = ["nodev" "rw" "user" "exec" "nosuid" "nofail" "x-gvfs-show"];
      label = "Storage";
    };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/517812dc-1380-4088-905e-0f546209fee0";
    };
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
