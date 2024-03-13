{ pkgs, lib, ...}:

let
  steam_autostart = (
    pkgs.makeAutostartItem { 
      name = "steam"; 
      package = my_steam;
      after = "-nochatui -nofriendsui -silent";
    };
  );
in
{
  environment.systemPackages = with pkgs; [
    steam_autostart
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall =true;
  };
}