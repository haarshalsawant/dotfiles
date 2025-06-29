{
  pkgs,
  ...
}:

{
  # <-- Environment packages -->
  environment.systemPackages = with pkgs; [

    # Browsers
    firefox

    # Notion Enhancer With patches
    (pkgs.callPackage ./_notion-app-enhanced { })

    # Terminal
    ghostty

    # Code editors
    figma-linux
    vscode-fhs
    jetbrains.pycharm-community-bin
    jetbrains.webstorm
    # android-studio

    # Communication apps
    slack
    vesktop
    telegram-desktop
    zoom-us
    element-desktop
    signal-desktop

    # Common desktop apps
    postman
    github-desktop
    anydesk
    drawio
    electrum
    qbittorrent
    obs-studio
    libreoffice-qt6-fresh
    obsidian

    # <-- Tools -->
    electron
    toolbox
    umlet

    gdb
    gcc
    gnumake
    cmake
    cmakeWithGui
    ninja
    clang
    pkg-config

    gtk4
    glib
    pango
    gdk-pixbuf
    gobject-introspection
    libepoxy
  ];
}
