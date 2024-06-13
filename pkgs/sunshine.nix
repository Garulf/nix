{ config, pkgs, lib, ...}:

let
  cfg = config.services.sunshine;
  sunshineOverride = pkgs.unstable.sunshine.override {
    cudaSupport = true;
    stdenv = pkgs.cudaPackages.backendStdenv;
  };
in

with lib;

{
  options = {
    services.sunshine_custom = {
      enable = mkEnableOption (mdDoc "Sunshine");
    };

  };

  config = mkIf cfg.enable {
    

    environment.systemPackages = with pkgs; [
      sunshineOverride
    ];

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${sunshineOverride}/bin/sunshine";
    };

    systemd.user.services.sunshine = {
      description = "Sunshine is a Game stream host for Moonlight.";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = "5";
        ExecStart = "${config.security.wrapperDir}/sunshine";
      };
    };

    services.avahi.publish.userServices = true;

    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';


    networking.firewall.allowedTCPPorts = [ 
      47990 # Sunshine admin
      47984 # Sunshine
      47989 # Sunshine
      47990 # Sunshine
      48010 # Sunshine
    ];
    networking.firewall.allowedUDPPortRanges = [ 
      { from = 47998; to = 48000; } # Sunshine
    ];

  };
}
