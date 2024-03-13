{ pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [
    sunshine
  ];

  security.wrappers = {
     sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };
  };

  systemd.user.services.sunshine = {
    description = "Sunshine is a Game stream host for Moonlight.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      AmbientCapabilities = "CAP_SYS_ADMIN";
      CapabilityBoundingSet = "CAP_SYS_ADMIN";
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
    };
  };

  services.avahi.publish.userServices = true;

  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}