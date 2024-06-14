{ config, pkgs, lib, ...}:

let
  sunshineOverride = pkgs.unstable.sunshine.override {
    cudaSupport = true;
    stdenv = pkgs.cudaPackages.backendStdenv;
  };
in

with lib;

{
  services.sunshine = {
    package = sunshineOverride;
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
