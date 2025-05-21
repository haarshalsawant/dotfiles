{
  pkgs,
  userConfig,
  ...
}:

{
  imports = [
    ./modules
  ];

  programs.home-manager.enable = true;
  # services.syncthing.enable = true;

  home = {
    username = userConfig.username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = userConfig.stateVersion;
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      # Notion Enhancer With patches
      (pkgs.callPackage ./modules/notion-app-enhanced { })

      # Code editor
      vscode-fhs
      android-studio

      # Communication apps
      vesktop
      telegram-desktop
      zoom-us
      element-desktop

      # Common desktop apps
      postman
      github-desktop
      anydesk
      drawio
      electrum
      blender-hip
      gimp
      graphicsmagick

      # Terminal
      kitty
      neovim

      # Utilities
      tmux
      coreutils
      fastfetch
      xclip
      curl
      wget
      tree
      asar
      fuse
      nh
      stow
      zellij
      bat
      direnv
      zoxide
      eza
      ripgrep
      fzf
      fd
      file
      bashInteractive
      lsd
      tea
      less
      findutils
      hub
      ruby
      xdg-utils
      pciutils
      cheat
      nixos-shell

      # Nix Tools
      nix-prefetch-github

      # Language Servers
      lua-language-server
      nil

      # System Monitoring
      inxi
      procs
      glances
      htop

      # Extractors
      unzip
      unrar
      p7zip
      xz
      zstd
      cabextract

      # git
      git
      git-lfs
      gh
      delta
      mergiraf
      lazygit
    ];
  };
}
