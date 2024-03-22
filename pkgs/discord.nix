{ pkgs, lib, ...}:

{

  desktopItems = [
    (pkgs.makeDesktopItem rec {
      name = "Sonic Robo Blast 2";
      exec = "test";
      icon = "test";
      comment = "test";
      desktopName = "test";
      genericName = "test";
      categories = [ "Game" ];
    })
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