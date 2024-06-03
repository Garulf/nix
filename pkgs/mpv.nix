{ pkgs, lib, ...}:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ 
          self.mpvScripts.mpris;
          self.mpvScripts.mpv-osc-modern;
          self.mpvScripts.modernx;
          self.mpvScripts.sponsorblock;
          self.mpvScripts.quality-menu;
          self.mpvScripts.youtube-upnext;
          self.mpvScripts.mpv-notify-send;
        ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    mpv
    open-in-mpv
  ];

}
