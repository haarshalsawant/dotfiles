{
  pkgs,
  lib,
  config,
  ...
}:

{
  languages.rust = {
    enable = true;
    channel = "stable"; # Consider "nightly" or "beta" if needed
    # Explicitly list common components for clarity and completeness
    components = [
      "rustc"
      "cargo"
      "clippy"
      "rustfmt"
      "rust-analyzer" # For IDEs
      "rust-std" # Standard library, useful for cross-compilation and some tools
    ];
    # Add cross-compilation targets if needed, e.g.:
    # targets = [ "wasm32-unknown-unknown", "aarch64-unknown-linux-gnu" ];
  };

  # Pre-commit hooks for code quality
  # Run `devenv git-hooks install` or `pre-commit install` to activate.
  git-hooks.hooks = {
    rustfmt.enable = true; # Auto-formats Rust code
    clippy = {
      enable = true; # Lints Rust code for common mistakes and style issues
      # settings.denyWarnings = true; # Optionally fail on warnings
    };
  };
  # If your Cargo.toml is not at the root of your project, specify its path:
  # pre-commit.settings.rust.cargoManifestPath = "./my-crate/Cargo.toml";

  # Useful Rust development packages
  packages =
    [
      pkgs.cargo-edit # For `cargo add`, `cargo rm`, `cargo upgrade`
      pkgs.cargo-watch # For watching files and re-running commands like `cargo check` or `cargo test`
      pkgs.lldb # Debugger (or pkgs.gdb)
      # pkgs.valgrind    # For memory profiling on Linux
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin (
      with pkgs.darwin.apple_sdk;
      [
        frameworks.Security # Often required for crates dealing with TLS/crypto
      ]
    );

  enterShell = ''
    echo "Rust $(rustc --version)"
    echo "Cargo $(cargo --version)"
    echo "---"
    echo "Key tools available:"
    echo "  - rustc, cargo, clippy, rustfmt, rust-analyzer"
    echo "  - cargo-edit (for 'cargo add', 'cargo rm')"
    echo "  - cargo-watch (for 'cargo watch -x check')"
    echo "  - lldb (debugger)"
    echo "  - Pre-commit hooks for rustfmt and clippy are configured (run 'devenv git-hooks install' or 'pre-commit install' to enable)."
    echo "  - Mold linker is enabled by default on Linux x86_64 (if no cross-targets) for faster linking."
  '';

  # See full reference at https://devenv.sh/reference/options/
}
