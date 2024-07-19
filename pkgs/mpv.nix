{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    (
      unstable.mpv.override {
        scripts = [ 
          mpvScripts.mpris
          mpvScripts.sponsorblock
          mpvScripts.quality-menu
          mpvScripts.modernx
          mpvScripts.quality-menu
          mpvScripts.youtube-upnext
        ];
      }
    )
    plex-mpv-shim
    open-in-mpv
  ];

}
