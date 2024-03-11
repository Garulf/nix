{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    virt-viewer
    virt-manager
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

  services.networking.websockify = {
    enable = true;
    sslCert = "/https-cert.pem";
    sslKey = "/https-key.pem";
    portMap = {
      "5900" = 5900;
    };
  };
}