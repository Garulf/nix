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
        ];
      }
    )
    open-in-mpv
  ];

}
