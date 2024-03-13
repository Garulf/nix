{ pkgs, lib, ...}:

{
  systemd.user.services.sunshine = {
    description = "Sunshine is a Game stream host for Moonlight.";
    after = [ "network.target" "multi-user.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
    };
  };

  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}