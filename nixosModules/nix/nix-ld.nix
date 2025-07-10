{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf genAttrs;
in
{
  # run unpatched linux binaries with nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = builtins.attrValues {
      inherit (pkgs)
        openssl
        curl
        glib
        util-linux
        glibc
        icu
        libunwind
        libuuid
        zlib
        libsecret
        # graphical
        freetype
        libglvnd
        libnotify
        SDL2
        vulkan-loader
        gdk-pixbuf
        ;
      inherit (pkgs.stdenv.cc) cc;
      inherit (pkgs.xorg) libX11;
    };
  };
}
