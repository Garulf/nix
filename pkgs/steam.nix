{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    steam
  ];

  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall =true;
  };
}
