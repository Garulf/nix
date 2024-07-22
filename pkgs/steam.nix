{ pkgs, lib, ...}:

{
  programs.steam = {
      enable = true;
      package = pkgs.unstable.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
  };
  hardware.steam-hardware.enable = true;
}
