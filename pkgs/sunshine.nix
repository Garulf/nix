{ pkgs, lib, ...}:

{
  systemd.user.services.sunshine = {
    description = "Sunshine is a Game stream host for Moonlight.";
    AmbientCapabilities= [ "CAP_SYS_ADMIN" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
    };
  };

  services.avahi.publish.userServices = true

  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}