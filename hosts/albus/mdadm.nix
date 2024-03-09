{ config, lib, pkgs, ... }:
{
  # boot.initrd.preLVMCommands = ''
  #   mdadm --run /dev/md127
  # '';

  systemd.services.raid-monitor = {
    description = "Mdadm Raid Monitor";
    wantedBy = [ "multi-user.target" ];
    after = [ "postfix.service" ];
    serviceConfig.ExecStart = "${pkgs.mdadm}/bin/mdadm --assemble";
  };

  environment.etc."mdadm.conf".text = ''
    MAILADDR root
    ARRAY /dev/md0 level=raid5 num-devices=4 metadata=1.2 name=albus:0 UUID=7673361d:6833b71b:2069f66f:ed297107
      devices=/dev/sda1,/dev/sdb1,/dev/sdc1,/dev/sdd1
  '';
}