{ config, pkgs, lib, ...}:

{
  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = 3031;
        grpc_listen_port = 0;
      };
      positions = {
        filename = "/tmp/positions.yaml";
      };
      clients = [{
        url = "https://loki.local.garulf.online/loki/api/v1/push";
      }];
      scrape_configs = [{
        job_name = "journal";
        journal = {
          max_age = "36h";
          labels = {
            job = "systemd-journal";
            host = "${config.networking.hostName}";
          };
        };
        relabel_configs = [{
          source_labels = [ "__journal__systemd_unit" ];
          target_label = "unit";
        }];
      }];
    };
    # extraFlags
  };
}