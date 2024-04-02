{ pkgs, lib, ...}:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    mpv
  ];

}
