{ pkgs, lib, ...}:

{
  systemd.user.services.discord = {
    description = "Launches Discord on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.discord}/bin/discord";
    };
  };
}