{ pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [
    sunshine
  ];

  systemd.user.services.sunshine = {
    description = "Sunshine is a Game stream host for Moonlight.";
    wantedBy = [ "graphical-session.target" ];
    ambientCapabilities = "CAP_SYS_ADMIN";
    serviceConfig = {
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