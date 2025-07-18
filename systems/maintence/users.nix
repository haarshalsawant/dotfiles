{
  home-manager.users.c0d3h01 = {
    secrets.enable = false;

    garden.programs.defaults = {
      shell = "zsh";
      browser = "firefox";
    };

    programs = {
      # Home Manager Gnome Settings
      gnome-settings.enable = false;
      # syncthing.enable = false;

      git.signing.key = "3E7C7A1B5DEDBB03";

      # browser
      firefox.enable = true;
      chromium.enable = false;

      # Shells
      zsh.enable = true;
      # fish.enable = true;

      # Desk Apps
      discord.enable = false;
      ghostty.enable = false;
    };
  };
}
