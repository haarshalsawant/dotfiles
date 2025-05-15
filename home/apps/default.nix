{ config, pkgs, ... }:

let
  stablePkgs = with pkgs.stable; [
    # Notion Enhancer With patches
    (pkgs.callPackage ./notion-app-enhanced { })

    # Code editor
    vscode-fhs

    # Development desktop apps
    postman
    github-desktop

    # Communication apps
    vesktop
    telegram-desktop
    zoom-us
    element-desktop

    # Common desktop apps
    anydesk
    drawio
    electrum
  ];

  unstablePkgs = with pkgs; [];
in {
  home.packages = stablePkgs ++ unstablePkgs;

  # imports = [
  #   ./tools
  # ];
}