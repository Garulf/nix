{ pkgs, lib, ...}:

{
  systemd.user.services.discord = {
    description = "Discord Chat Application";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.discord}/bin/discord";
    };
  };
}