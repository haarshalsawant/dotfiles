{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;

    theme = lib.mkDefault {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

    cursorTheme = lib.mkDefault {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = lib.mkDefault {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style.name = "adwaita-dark";
  # };
}
