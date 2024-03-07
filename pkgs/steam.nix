{ pkgs, lib, ...}:

{
  systemd.user.services.steam = {
    description = "Launches Steam on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5";
      ExecStart = "${pkgs.steam}/bin/steam -nochatui -nofriendsui -silent";
    };
  };
}