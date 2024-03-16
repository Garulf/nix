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