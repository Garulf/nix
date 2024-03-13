{ pkgs, lib, ...}:

let
  steam_autostart = (
    pkgs.makeAutostartItem { 
      name = "steam_auto"; 
      package = pkgs.steam;
      after = "-nochatui -nofriendsui -silent";
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    steam_autostart
  ];

  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall =true;
  };
}