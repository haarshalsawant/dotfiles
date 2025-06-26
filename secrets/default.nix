{
  config,
  inputs,
  userConfig,
  ...
}:

{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age = {
    identityPaths = [
      "${config.home.homeDirectory}/.ssh/id_ed25519"
    ];

    secrets = {
      ssh-key.file = ./ssh-key.age;
    };
  };
}
