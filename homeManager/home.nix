{
  username,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  # Function to recursively import modules from a directory
  # It takes a path and returns a list of modules.
  # It excludes files/directories starting with an underscore.
  autoImportModules =
    dir:
    let
      # Read the contents of the directory
      contents = builtins.readDir dir;

      # Filter out files/directories that start with '_'
      filteredContents = lib.attrsets.filterAttrs (
        name: type: !(lib.strings.hasPrefix "_" name)
      ) contents;

      # Process each item
      modules = lib.attrsets.mapAttrsToList (
        name: type:
        let
          path = "${dir}/${name}";
        in
        if type == "directory" then
          # If it's a directory, recursively import modules from it
          autoImportModules path
        else if type == "regular" && lib.strings.hasSuffix ".nix" name then
          # If it's a .nix file, import it as a module
          import path
        else
          # Ignore other file types
          null
      ) filteredContents;
    in
    # Flatten the list of modules (since directories return a list of modules)
    lib.lists.flatten (lib.lists.filter (x: x != null) modules);

  # Define the path to your Home Manager modules directory!
  homeManagerModulesPath = ./modules;

in
{
  imports = [
    ../secrets
  ]

  # Automatically import all modules from homeManager/modules ;)
  ++ (autoImportModules homeManagerModulesPath);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = lib.trivial.release;
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      # Secrets management tool
      sops

      # Terminal Utilities
      neovim
      tmux
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
      fd
      file
      bash
      bashInteractive
      lsd
      tea
      less
      procs
      glances
      cheat # CheatSheet
      bottom
      just
      just-formatter
      fzf # fuzzy finder CLI
      tree-sitter # Parser generator tool
      gdu # Disk usage analyzer CLI

      # Language Servers
      lua-language-server
      nil
      just-lsp

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
