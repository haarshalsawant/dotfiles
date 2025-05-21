{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    myModules.rust.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Rust modules";
    };
  };

  config = lib.mkIf config.myModules.rust.enable {
    environment.systemPackages = with pkgs; [
      rustup
      rustfmt
      rust-analyzer
    ];
  };
}
