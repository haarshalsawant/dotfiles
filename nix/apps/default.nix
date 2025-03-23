{ config, pkgs, lib, ... }:

{
  imports = [
    ./android.nix
    ./devtools
    ./printing.nix
    # ./virtual.nix
  ];

  # System configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs = lib.mkDefault 8;
      cores = lib.mkDefault 4;
    };
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };
  };

  # Enable flatpak support
  # services.flatpak.enable = true;

  # SDK license acceptance
  nixpkgs.config.android_sdk.accept_license = true;

  # Development environment packages
  environment.systemPackages =
    let
      # Group packages by category for better organization
      devTools = with pkgs; [
        # Utilities
        nix-ld

        # Editors and IDEs
        vscode-fhs
        jetbrains.webstorm

        # Version control
        git
        github-desktop

        # JavaScript/TypeScript
        nodejs
        nodePackages.node2nix
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        nodePackages.prettier
        nodePackages.eslint

        # Java
        openjdk
        gradle

        # C/C++
        clang
        gnumake
        cmake
        ninja

        # Graphics libraries
        glib
        glfw
        glew
        glm
        sfml

        # GTK development tools
        gtk3
        gtk4
        gobject-introspection
        pkg-config
        gtkmm4 # C++ bindings for GTK4
        gtkmm3 # C++ bindings for GTK3

        # API Development
        postman
      ];

      communicationApps = with pkgs; [
        discord
        telegram-desktop
        slack
        zoom-us
        element-desktop
      ];

      desktopApps = with pkgs; [
        # Custom patched Notion
        (pkgs.callPackage ./notion-app-enhanced { })
        libreoffice
        tor-browser
        spotify
        transmission_4-gtk
        google-chrome
        anydesk
      ];

      networkingTools = with pkgs; [
        metasploit
        nmap
        wireshark
        tcpdump
      ];

      androidTools = with pkgs; [
        android-studio
        flutter
        android-tools
      ];
    in
    devTools ++ communicationApps ++ desktopApps ++ networkingTools ++ androidTools;
}
