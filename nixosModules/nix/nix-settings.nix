{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  # Set the NixOS state version to match the release version
  # This prevents system-changing updates when upgrading NixOS
  system.stateVersion = lib.trivial.release;

  # Set the hostname from the user configuration
  networking.hostName = userConfig.hostname;

  # Nix package manager configuration
  nix = {
    # Enable the Nix package manager
    enable = true;

    # Validate configuration for consistency
    checkConfig = true;

    # Garbage collection settings
    gc = {
      # Enable automatic garbage collection
      automatic = true;

      # Remove packages older than 3 days
      options = "--delete-older-than 3d";
    };

    # Detailed Nix settings
    settings = {
      # Show stack traces for better debugging
      show-trace = true;

      # Use all available CPU cores for building
      cores = 0;

      # log output for failed builds
      log-lines = 30;

      # Optimize the Nix store by deduplicating identical files via symlinks
      auto-optimise-store = true;

      # Enable flake references without using the central registry
      use-registries = true;
      flake-registry = "";

      # Automatically determine optimal number of parallel jobs
      max-jobs = "auto";

      # Continue building other derivations if one fails
      # Useful for maintaining build cache during large operations
      keep-going = true;

      # Preserve derivations and outputs for direnv compatibility
      keep-derivations = true;
      keep-outputs = true;

      # Store Nix data in XDG-compliant locations
      use-xdg-base-directories = true;

      # Disabled: Build from source as fallback when binary fails
      # fallback = true;

      # Don't warn about uncommitted changes in git repositories
      warn-dirty = false;

      # Set maximum parallel TCP connections for fetching packages
      # 0 would mean unlimited; 50 provides good performance
      http-connections = 50;

      # Use /var/tmp instead of RAM for builds to avoid tmpfs issues
      build-dir = "/var/tmp";

      # Define users allowed to perform privileged Nix operations
      trusted-users = [
        "root"
        "@wheel"
      ];

      # Enable flakes and the modern nix command-line interface
      experimental-features = [
        # enables flakes, needed for this config
        "flakes"

        # enables the nix3 commands, a requirement for flakes
        "nix-command"

        # Allows Nix to automatically pick UIDs for builds, rather than creating nixbld* user accounts
        # which is BEYOND annoying, which makes this a really nice feature to have
        "auto-allocate-uids"

        # allows Nix to execute builds inside cgroups
        # remember you must also enable use-cgroups in the nix.conf or settings
        "cgroups"

        # enable the use of the fetchClosure built-in function in the Nix language.
        "fetch-closure"

        # allow parsing TOML timestamps via builtins.fromTOML
        "parse-toml-timestamps"
      ];

      # Configure binary caches for faster package downloads
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      # Public keys for the binary caches (for verification)
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
