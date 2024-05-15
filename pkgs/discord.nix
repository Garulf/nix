{ pkgs, lib, ...}:

{

  environment.systemPackages = with pkgs; [
    discord
  ];
  systemd.user.services.discord = {
    description = "Launches Discord on login.";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      StandardOutput=null;
      Restart = "always";
      RestartSec = "5";
      ExecStart = "${pkgs.discord}/bin/discord --start-minimized";
    };
  };
}
