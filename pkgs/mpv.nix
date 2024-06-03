{ pkgs, lib, ...}:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ 
          mpvScripts.mpris
          mpvScripts.mpv-osc-modern
          mpvScripts.modernx
          mpvScripts.sponsorblock
          mpvScripts.quality-menu
          mpvScripts.youtube-upnext
          mpvScripts.mpv-notify-send
        ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    mpv
    open-in-mpv
  ];

}
