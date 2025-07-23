{
  inputs,
  self,
  config,
  ...
}:

{
  imports = [ inputs.sops.homeManagerModules.sops ];

  sops = {
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
    };

    secrets = {
      "element" = {
        sopsFile = "${self}/secrets/element";
        path = "/${config.home.homeDirectory}/.config/sops/age/element";
        format = "binary";
      };
      "solana" = {
        sopsFile = "${self}/secrets/solana";
        path = "/${config.home.homeDirectory}/.config/sops/age/solana";
        format = "binary";
      };
    };
  };
}
