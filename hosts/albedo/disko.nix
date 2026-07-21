# Declarative disk layout for the Albedo host (disko).
#
# Layout:
#   - NVMe #2 (1TB): 2G ESP + LUKS2 -> LVM (64G swap + btrfs root subvolumes)
#   - 2x 4TB HDD:    ZFS mirror pool `tank`, natively encrypted (NixOS-only)
#
# !!! BEFORE RUNNING `disko`, replace every REPLACE_* device path below with the
# real, STABLE identifiers from `ls -l /dev/disk/by-id/` on the target machine.
# Using /dev/disk/by-id/* (not /dev/sdX or /dev/nvmeXn1) is important so the pool
# and LUKS device survive re-cabling / enumeration changes.
#
# Install-time prerequisites (see the plan for full steps):
#   * /tmp/albedo.passphrase        -> your LUKS passphrase (LUKS keyslot 0)
#   * /etc/zfs/keys/tank.key        -> 32 random bytes for the ZFS pool
#                                      (`dd if=/dev/urandom of=/etc/zfs/keys/tank.key bs=32 count=1`)
#   * a raw partition on the USB stick labeled `albedo-key` holding 4096 random
#     bytes (LUKS keyslot 1, enrolled manually after disko — see plan)
{
  disko.devices = {
    disk = {
      # ---- NVMe #2: NixOS system disk ----
      nixos = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-REPLACE_ME_nixos";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G"; # deliberately large: holds many systemd-boot generations
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0022" "dmask=0022" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                # Creation: enroll the passphrase from this file (keyslot 0).
                passwordFile = "/tmp/albedo.passphrase";
                # Runtime unlock: auto-open from the USB keyfile, fall back to the
                # passphrase prompt if the stick is absent. (The USB keyslot is
                # enrolled manually after disko so its size matches keyFileSize.)
                settings = {
                  allowDiscards = true;
                  keyFile = "/dev/disk/by-partlabel/albedo-key";
                  keyFileSize = 4096;
                  fallbackToPassword = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "vg";
                };
              };
            };
          };
        };
      };

      # ---- 2x 4TB HDD: ZFS mirror members ----
      hdd0 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-REPLACE_ME_hdd0";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "tank";
            };
          };
        };
      };
      hdd1 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-REPLACE_ME_hdd1";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "tank";
            };
          };
        };
      };
    };

    # ---- LVM inside the LUKS container: swap + btrfs root ----
    lvm_vg = {
      vg = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "64G"; # = RAM, so hibernate works
            content = {
              type = "swap";
              resumeDevice = true; # sets boot.resumeDevice for hibernate resume
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" "-L" "nixos" ];
              subvolumes = {
                "root" = { mountpoint = "/"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "persist" = { mountpoint = "/persist"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "log" = { mountpoint = "/var/log"; mountOptions = [ "compress=zstd" "noatime" ]; };
              };
            };
          };
        };
      };
    };

    # ---- ZFS mirror pool `tank` (native encryption, NixOS-only) ----
    zpool = {
      tank = {
        type = "zpool";
        mode = "mirror";
        options.ashift = "12";
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
          mountpoint = "none";
          # Native encryption. The 32-byte raw key must exist at this path during
          # `zpool create` (installer) and on the installed root at boot.
          encryption = "aes-256-gcm";
          keyformat = "raw";
          keylocation = "file:///etc/zfs/keys/tank.key";
        };
        datasets = {
          data = {
            type = "zfs_fs";
            mountpoint = "/mnt/tank";
          };
        };
      };
    };
  };
}
