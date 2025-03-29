{ config
, username
, pkgs
, ...
}:
{
  programs = {
    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = false;
  };

  services = {
    # SSH support
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
        AllowUsers = [ "${username}" ];
      };
    };
    # Printing support
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip ];
    };
    avahi = {
      enable = true;
      openFirewall = true;
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 200;
    priority = 100;
  };
}
