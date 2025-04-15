{
  config,
  pkgs,
  userConfig,
  ...
}:
{
  # Enable X server and GNOME
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
      displayManager.gdm.enable = true;
    };
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.udisks2.filesystem-mount") == 0 &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';

  # Exclude unwanted GNOME packages
  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-backgrounds
      gnome-font-viewer
      epiphany
      yelp
      baobab
      gnome-weather
      gnome-text-editor
      gnome-connections
      gnome-music
      gnome-remote-desktop
      gnome-usage
      gnome-contacts
      gnome-system-monitor
    ];

    systemPackages = with pkgs; [
      gnome-photos
      gnome-tweaks
      # micro
      libreoffice
      rhythmbox
      qbittorrent

      gnome-photos
      gnome-tweaks
      libreoffice
      rhythmbox
      qbittorrent
      gnomeExtensions.gsconnect
      gnomeExtensions.dash-to-dock
    ];

    pathsToLink = [
      "/share/icons"
      "/share/applications"
    ];
  };

  home-manager.users.${userConfig.username} =
    { pkgs, ... }:
    {
      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "gsconnect@andyholmes.github.io"
            "dash-to-dock@micxgx.gmail.com"
          ];
        };
        # interface
        "org/gnome/desktop/interface" = {
          enable-hot-corners = true;
          clock-show-weekday = true;
          clock-show-seconds = false;
          clock-show-date = true;
          clock-format = "12h";
          color-scheme = "prefer-dark";
        };
        # keyboard
        "org/gnome/desktop/peripherals/keyboard" = {
          numlock-state = true;
          remember-numlock-state = true;
        };
        # touchpad
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
          natural-scroll = true;
        };
        # workspaces
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          workspaces-only-on-primary = true;
        };
        # wallpaper
        "org/gnome/desktop/background" = {
          picture-uri = "file://${
            config.users.users.${userConfig.username}.home
          }/dotfiles/assets/wallpapers/Dynamic-Wallpapers/Light/Beach-light.png";
          picture-uri-dark = "file://${
            config.users.users.${userConfig.username}.home
          }/dotfiles/assets/wallpapers/Dynamic-Wallpapers/Dark/Beach-dark.png";
          picture-options = "zoom";
        };
      };

      xdg = {
        portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
          config = {
            common.default = "gnome";
          };
        };
      };
    };
}
