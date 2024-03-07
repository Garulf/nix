{ pkgs, lib, ...}:

{
  systemd.user.services.steam = {
    description = "Launches Openrgb on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5";
      ExecStart = "${pkgs.openrgb}/bin/openrgb --server --startminimized";
    };
  };
}