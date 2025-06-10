{
  pkgs,
  ...
}:

{
  imports = [
    ./tools
  ];

  # Enable flatpak repo : flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  # services.flatpak.enable = true;

  programs.appimage.enable = true;

  myModules = {
    docker.enable = true;
    # monitoring.enable = true;
    mysql.enable = true;
    # podman.enable = true;
    python.enable = true;
    r.enable = true;
    rust.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };

  # Environment packages
  environment.systemPackages = with pkgs; [
    go
    nodejs
    electron
    gdb
    glib
    gcc
    gnumake
    cmake
    ninja
    clang
    pkg-config
    jdk24
  ];
}
