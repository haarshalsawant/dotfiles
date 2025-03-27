{ config
, username
, pkgs
, ...
}:
{
  # VirtualMachine
  virtualisation.libvirtd.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];

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
        PermitRootLogin = "yes";
        GatewayPorts = "yes";
        X11Forwarding = true;
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
