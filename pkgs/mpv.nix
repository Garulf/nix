{ pkgs, lib, ...}:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ 
          self.mpvScripts.mpris
          self.mpvScripts.sponsorblock
          self.mpvScripts.qualitymenu
        ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    mpv
    open-in-mpv
  ];

}
