{
  inputs,
  config,
  ...
}:

{
  sops = {
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
    };

    secrets = {
      "password" = {
        sopsFile = ./c0d3h01/password;
        path = "/${config.home.homeDirectory}/.config/sops/age/password";
        format = "binary";
      };
      "element" = {
        sopsFile = ./c0d3h01/element;
        path = "/${config.home.homeDirectory}/.config/sops/age/element";
        format = "binary";
      };
      "solana" = {
        sopsFile = ./c0d3h01/solana;
        path = "/${config.home.homeDirectory}/.config/sops/age/solana";
        format = "binary";
      };
    };
  };
}
