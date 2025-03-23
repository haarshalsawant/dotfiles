{ pkgs, sprinkle, ... }:

{
  environment.systemPackages = (with pkgs; [
    # Language server.
    nil

    # Better progress visualization.
    nix-output-monitor
  ]) ++ (with sprinkle.output.package; [
    # Better `use nix`/`use flake` for `direnv`.
    nix-direnv
  ]);

  # Links `nix-direnv`'s code to `/run/current-system` so it can be easily
  # referenced.
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
