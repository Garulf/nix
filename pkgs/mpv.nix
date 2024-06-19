{ pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    (
      mpv.override {
        scripts = [ 
          mpvScripts.mpris
          mpvScripts.sponsorblock
          mpvScripts.quality-menu
        ];
      }
    )
    open-in-mpv
  ];

}
