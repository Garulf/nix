{ pkgs, lib, ...}:

{
  programs.steam = {
    package = pkgs.unstable.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall =true;
  };
}
