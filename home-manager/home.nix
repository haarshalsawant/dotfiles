{
  lib,
  pkgs,
  declarative,
  inputs,
  ...
}:

{
  imports = [
    ./firefox.nix
    ./spicetify.nix
  ];

  programs.home-manager.enable = true;
  # services.syncthing.enable = true;
  manual.manpages.enable = false;

  home = {
    username = declarative.username;
    homeDirectory = "/home/${declarative.username}";
    stateVersion = lib.trivial.release;
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      # Terminal Utilities
      neovim
      vim
      tmux
      coreutils
      fastfetch
      xclip
      curl
      wget
      tree
      stow
      zellij
      bat
      zoxide
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
      xdg-utils
      pciutils
      inxi
      procs
      glances
      cheat
      tree-sitter
      devenv
      just
      just-formatter
      pre-commit

      # Language Servers
      lua-language-server
      nil

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

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config.log_filter = "ignore-everything-forever";
    };
  };
}
