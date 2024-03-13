{ pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [
    sunshine
  ];

  wrapper = {
    security.wrappers.sunshine = {
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
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${wrapper.security.wrapperDir}/sunshine";
    };
  };

  services.avahi.publish.userServices = true;

  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}