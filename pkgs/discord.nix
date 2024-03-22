{ pkgs, lib, makeDesktopItem, ...}:

{

  desktopItems = [
    (makeDesktopItem rec {
      name = "Sonic Robo Blast 2";
      exec = finalAttrs.pname;
      icon = finalAttrs.pname;
      comment = finalAttrs.meta.description;
      desktopName = name;
      genericName = name;
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