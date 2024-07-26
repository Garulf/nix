{ config, pkgs, lib, ...}:

let
  sunshineOverride = pkgs.sunshine.override {
    cudaSupport = true;
    stdenv = pkgs.cudaPackages.backendStdenv;
  };
in

with lib;

{

  environment.systemPackages = with pkgs; [
    (unstable.sunshine.override { cudaSupport = true; })
  ];

  services.sunshine = {
    package = (pkgs.unstable.sunshine.override { cudaSupport = true; });
    enable = false;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
