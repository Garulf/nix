{ config, pkgs, lib, ...}:

let
  cfg = config.services.rpiplay;
in

with lib;

{
  options = {
    services.rpiplay = {
      enable = mkEnableOption (mdDoc "Rpiplay");
    };

  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      rpiplay
    ];

    services.avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };

    networking.firewall.allowedTCPPorts = [
      7000 # rpiplay 1
      7100 # rpiplay 2
    ];
    networking.firewall.allowedUDPPortRanges = [
      { from = 6000; to = 6001; } # rpiplay
      { from = 7100; to = 7100; } # rpiplay
    ];

    systemd.user.services.rpiplay = {
      description = "rpiplay airplay mirror server.";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = "5";
        ExecStart = "${pkgs.rpiplay}/bin/rpiplay -n ${config.networking.hostName} -b";
      };
    };
  };
}