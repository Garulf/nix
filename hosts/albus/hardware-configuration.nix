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
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.kernelParams = [ "ip=dhcp" ];
  boot.kernelModules = [ "kvm-amd" "amd_iommu=on" "vfio-pci" "igp" ];
  boot.initrd = {
    kernelModules = [ "dm-snapshot" ];
    availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "btusb"
      "btrtl"
      "btintel"
      "bcm203x"
    ];
    systemd.users.root.shell = "/bin/cryptsetup-askpass";
    network = {
      enable = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrE0XdIUZ4NCb3KuA9c2aUndK8k+dO7qB1EqrvMiFFC+XKHjqoPQyQmB3eObQtEEfIxKYhrkiUmp5SkRfXXCwomPYaXMgtv1YSleTaNbH/uMmCR/G/PXQdOcOcMrZcpRZw/tD32DEWkLgWTVy9A+lyh+rRGw+oj0wiuW5qgod/tiZ06GoqDL7oZA2W49ngPgooz22OfuD2BbMdyp7aAev7kLiNGXsHhzwB+QwdxPPm+tHKUMiE82hAnNeEf0aOtZQEU9LuNa3FyuxvMRNxA+iRva3FFwgEvdF7dtWUtZhSvbcdMk0Q4jb86UCTurcYAGe6fxtZ77YEp8XFbWrZzJp8hkiA2j9bbGC1cP9MprqUlhjT3ABHZnB+ZL/kqlOZiMKnxXCJ96SSrLfreX0gkKw26kdWyGaYEzt3fBJq2XQMBSPk3C/A/nQzFptAdPi9p6ZkZumq5tYGQ/KDPw0VjVIfPOXFLrBljDU4t3HpnkynV+GcZMX0ZAs3RQwJpApy02itZmwjpWMqnGgzb0Od1/srWOJBasyWnN0ICVvDZhdakGze2vP4U623VyxyfdFURKpF2kZ1Lp0G35Khg5ZMFgfD0uA4BvFjzxWXPjecdsy0ZQYcFyxf6ZfyTPhXLdka7z1GT+Y5wEiACBdphuyjbh70qFl0TyfJnM62cGsXCVFHhQ== Generated By Termius" ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
      };
    };
  };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5fe0438d-a94d-48a3-a7cd-23cee5bb6821";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

 fileSystems."/home" =
   { device = "/dev/disk/by-uuid/5fe0438d-a94d-48a3-a7cd-23cee5bb6821";
     fsType = "btrfs";
     options = [ "subvol=home" "compress=zstd" "noatime" ];
   };

 fileSystems."/nix" =
   { device = "/dev/disk/by-uuid/5fe0438d-a94d-48a3-a7cd-23cee5bb6821";
     fsType = "btrfs";
     options = [ "subvol=nix" "compress=zstd" "noatime" ];
   };

 fileSystems."/persist" =
   { device = "/dev/disk/by-uuid/5fe0438d-a94d-48a3-a7cd-23cee5bb6821";
     fsType = "btrfs";
     options = [ "subvol=persist" "compress=zstd" "noatime" ];
     neededForBoot = true;
   };

 fileSystems."/var/log" =
   { device = "/dev/disk/by-uuid/5fe0438d-a94d-48a3-a7cd-23cee5bb6821";
     fsType = "btrfs";
     options = [ "subvol=log" "compress=zstd" "noatime" ];
     neededForBoot = true;
   };

 fileSystems."/boot" =
   { device = "/dev/disk/by-uuid/3269-C4D5";
     fsType = "vfat";
     options = [ "fmask=0022" "dmask=0022" ];
   };

  fileSystems."/mnt/Games" =
    { device = "/dev/nvme1n1p1";
      fsType = "ext4";
      options = ["nodev" "rw" "user" "exec" "nosuid" "nofail" "x-gvfs-show"];
      label = "Games";
    };

  fileSystems."/mnt/Storage" =
    { device = "/dev/md0";
      fsType = "ext4";
      options = ["nodev" "rw" "user" "exec" "nosuid" "nofail" "x-gvfs-show"];
      label = "Storage";
    };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/101adac7-4264-45fd-bb10-1afd2b3e0f32";
    }
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
