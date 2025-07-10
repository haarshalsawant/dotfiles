{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko

    ../desktop/gnome.nix

    ../hardware/amd.nix
    ../hardware/btrfs-maintence.nix
    ../hardware/disko-btrfs.nix
    ../hardware/firmware.nix

    ../networking/dns.nix
    ../networking/network.nix
    ../networking/optimizations.nix
    ../networking/ssh.nix

    ../nix/config.nix
    ../nix/nix-ld.nix
    ../nix/nix-settings.nix

    ../programs/apps.nix
    # ../programs/docker.nix
    ../programs/mysql.nix
    ../programs/podman.nix
    ../programs/wireshark.nix

    ../security/firewall.nix
    ../security/siteblocker.nix

    ../services/acpid.nix
    ../services/ananicy.nix
    ../services/appImage.nix
    ../services/earlyoom.nix
    ../services/flatpak.nix
    ../services/libvirt.nix
    ../services/oomd.nix
    ../services/pager.nix
    ../services/udevRules.nix

    ../system/audio.nix
    ../system/docs.nix
    ../system/fonts.nix
    ../system/power.nix
    ../system/printing.nix
  ];
}
