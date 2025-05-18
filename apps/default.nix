{ pkgs, userConfig, ... }:

{
  imports = [
    ./tools
  ];

  # Enable flatpak repo : flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  # services.flatpak.enable = true;

  programs.appimage.enable = true;
  programs.adb.enable = true;

  myModules = {
    # androidTools = true;
    # dockerTools = true;
    # hackerMode = true;
    # mysqlTools = true;
    # podmanTools = true;
    pythonTools = true;
    rustTools = true;
  };

  # Environment packages
  environment.systemPackages =
    let
      unstablePkgs = with pkgs; [
        # Browser
        firefox-esr

        # -+ Common Developement tools
        nodejs
        yarn

        # Electron tools
        electron
        # electron-fiddle

        # C/C++
        gdb
        gcc
        clang
        gnumake
        cmake
        ninja
        clang-tools

        # Gtk tools
        pkg-config

        # Android Tools
        flutter
        openjdk
        # androidsdk
      ];
    in
    unstablePkgs;
}
