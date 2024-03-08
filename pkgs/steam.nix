{ pkgs, lib, ...}:

{
  systemd.user.services.steam = {
    description = "Launches Steam on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5";
      ExecStart = "${pkgs.steam}/bin/${pkgs.steam.pname} -nochatui -nofriendsui -silent";
    };
  };

  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall =true;
  };
}