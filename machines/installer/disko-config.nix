{
  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "Nix_EFI";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              name = "Nix_root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                ];
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                      "discard=async"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:5"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                      "discard=async"
                      "autodefrag"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                      "discard=async"
                    ];
                  };
                  "/@var" = {
                    mountpoint = "/var";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                      "discard=async"
                      "autodefrag"
                      "ssd_spread"
                    ];
                  };
                  "/@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd:9"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=60"
                      "discard=async"
                      "autodefrag"
                      "ssd_spread"
                    ];
                  };
                  "/@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [
                      "compress=no"
                      "noatime"
                      "ssd"
                      "nosuid"
                      "nodev"
                      "discard=async"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}