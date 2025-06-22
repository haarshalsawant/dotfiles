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
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress-force=zstd:3"
                      "ssd"
                      "noatime"
                      "space_cache=v2"
                      "commit=60"
                      "discard=async"
                      "autodefrag"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress-force=zstd:3"
                      "ssd"
                      "noatime"
                      "space_cache=v2"
                      "commit=60"
                      "discard=async"
                      "autodefrag"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress-force=zstd:3"
                      "ssd"
                      "noatime"
                      "space_cache=v2"
                      "commit=60"
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
