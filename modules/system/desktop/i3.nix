{ config
, pkgs
, user
, lib
, ...
}:
{
  # Enable X server and i3
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
          rofi
          feh
          arandr
          xorg.xrandr
          xorg.xbacklight
          pavucontrol
          networkmanagerapplet
          blueman
          pasystray
          redshift
          picom
          dunst
          lxappearance
          nitrogen
          autorandr
        ];
      };
      # Use GDM instead of LightDM for better Gnome integration
      displayManager.gdm = {
        enable = true;
        wayland = false; # Disable Wayland for better compatibility
      };
      desktopManager.gnome.enable = true;
      # excludePackages = with pkgs; [ xterm ];
    };
  };

  # Security policies
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.udisks2.filesystem-mount") == 0 &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';

  # System packages
  environment.systemPackages = with pkgs; [
    # Core utilities
    alacritty
    # micro
    # libreoffice
    # transmission_4-gtk
    # rhythmbox

    # System tools
    gparted
    gnome-disk-utility
    gnome-calculator
    gnome-screenshot
    gnome-system-monitor

    # Media
    vlc
    inkscape
    gthumb
  ];

  # Home manager configuration for i3
  home-manager.users.${user.username} = { pkgs, ... }: {
    # i3 configuration
    xsession.windowManager.i3 = {
      enable = true;
      config = rec {
        modifier = "Mod4"; # Windows key
        terminal = "alacritty";
        menu = "rofi -show drun";
        bars = [ ];
        gaps = {
          inner = 10;
          outer = 5;
        };
        window = {
          border = 2;
          titlebar = false;
        };
        keybindings = lib.mkOptionDefault {
          # Basic keybindings
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Workspace navigation
          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";

          # Layout
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          # System
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

          # Media controls
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
          "XF86AudioNext" = "exec --no-startup-id playerctl next";
          "XF86AudioPrev" = "exec --no-startup-id playerctl previous";

          # Screenshot
          "Print" = "exec --no-startup-id gnome-screenshot -i";
          "${modifier}+Print" = "exec --no-startup-id gnome-screenshot -a";
        };
      };
      extraConfig = ''
        # Autostart applications
        exec --no-startup-id nitrogen --restore
        exec --no-startup-id picom --config ~/.config/picom/picom.conf
        exec --no-startup-id dunst
        exec --no-startup-id nm-applet
        exec --no-startup-id blueman-applet
        exec --no-startup-id pasystray
        exec --no-startup-id redshift-gtk
        
        # Gnome integration
        exec --no-startup-id gnome-keyring-daemon --start --components=secrets
        exec --no-startup-id gnome-keyring-daemon --start --components=ssh
        exec --no-startup-id gnome-keyring-daemon --start --components=pkcs11
      '';
    };

    # GTK theming
    # gtk = {
    #   enable = true;
    #   cursorTheme = lib.mkForce {
    #     name = "Bibata-Modern-Classic";
    #     package = pkgs.bibata-cursors;
    #   };
    #   iconTheme = lib.mkForce {
    #     name = "Tela-dark";
    #     package = pkgs.tela-icon-theme;
    #   };
    #   theme = lib.mkForce {
    #     name = "Catppuccin-Mocha-Blue";
    #     package = pkgs.catppuccin-gtk.override {
    #       variant = "mocha";
    #       accents = [ "blue" ];
    #     };
    #   };
    #   gtk3.extraConfig = lib.mkForce {
    #     "gtk-application-prefer-dark-theme" = true;
    #   };
    #   gtk4.extraConfig = lib.mkForce {
    #     "gtk-application-prefer-dark-theme" = true;
    #   };
    # };

    # XDG configuration
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      };
      mime = {
        enable = true;
        # defaultApplications = {
        #   "application/x-bittorrent" = [ "transmission-gtk.desktop" ];
        #   "default-web-browser" = [ "firefox.desktop" ];
        # };
      };
    };

    # Additional configuration files
    home.file = {
      ".config/picom/picom.conf" = {
        text = ''
          # Shadow
          shadow = true;
          shadow-radius = 12;
          shadow-offset-x = -12;
          shadow-offset-y = -12;
          shadow-opacity = 0.2;
          
          # Fading
          fading = true;
          fade-in-step = 0.03;
          fade-out-step = 0.03;
          
          # Blur
          blur = true;
          blur-method = "dual_kawase";
          blur-strength = 5;
          
          # Other
          backend = "glx";
          vsync = true;
          unredir-if-possible = true;
        '';
      };
      ".config/dunst/dunstrc" = {
        text = ''
          [global]
          font = JetBrainsMono Nerd Font 10
          format = "<b>%s</b>\n%b"
          sort = true
          indicate_hidden = true
          alignment = left
          show_age_threshold = 60
          word_wrap = true
          ignore_newline = false
          geometry = "300x5-30+20"
          transparency = 0
          idle_threshold = 120
          monitor = 0
          follow = mouse
          sticky_history = true
          history_length = 20
          show_indicators = true
          line_height = 0
          separator_height = 2
          padding = 8
          horizontal_padding = 8
          separator_color = frame
          startup_notification = false
          dmenu = "/usr/bin/dmenu -p dunst:"
          browser = "/usr/bin/firefox -new-tab"
          
          [shortcuts]
          close = ctrl+space
          close_all = ctrl+shift+space
          history = ctrl+grave
          context = ctrl+shift+period
          
          [urgency_low]
          background = "#1e1e2e"
          foreground = "#cdd6f4"
          timeout = 4
          
          [urgency_normal]
          background = "#1e1e2e"
          foreground = "#cdd6f4"
          timeout = 6
          
          [urgency_high]
          background = "#1e1e2e"
          foreground = "#cdd6f4"
          timeout = 8
        '';
      };
    };
  };
}
