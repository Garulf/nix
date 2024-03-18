{ pkgs, lib, ...}:

{

  boot.kernelModules = [ "kvm-amd" "amd_iommu=on" "vfio-pci" ];
  boot.kernalParams = [ "iommu=pt" "amd_iommu=on" ];

  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    virt-viewer
    virt-manager
    virtiofsd
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
}