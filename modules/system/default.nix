{ user
, ...
}: {

  imports = [
    ./audio.nix
    ./boot.nix
    ./desktop
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./services.nix
  ];

  system.stateVersion = user.stateVersion;
  networking.hostName = user.hostname;
}
