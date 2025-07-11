with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
    nodePackages.prettier
  ];
}
