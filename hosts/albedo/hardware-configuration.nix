# Hardware bits for Albedo. Filesystems / swap / LUKS come from disko.nix,
# NOT from this file.
#
# NOTE: assumes an AMD CPU + NVIDIA GPU (same as albus). If this box is Intel,
# change: kvm-amd -> kvm-intel, amd_iommu=on -> intel_iommu=on, and
# hardware.cpu.amd.updateMicrocode -> hardware.cpu.intel.updateMicrocode.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./nvidia.nix # Albedo-specific (Blackwell open module); NOT ../common/nvidia.nix
  ];

  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_iommu=on" ];

  boot.initrd = {
    kernelModules = [ "dm-snapshot" ];
    # usb_storage + uas are REQUIRED so the USB LUKS keyfile is readable in initrd.
    availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "uas"
      "sd_mod"
    ];
  };

  # Recommended for Star Citizen (carried over from albus).
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
