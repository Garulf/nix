{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    virt-viewer
    virt-manager
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}