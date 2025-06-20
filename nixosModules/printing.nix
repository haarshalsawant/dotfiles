{
  services = {
    printing = {
      enable = true;
      openFirewall = true;
    };

    # Avahi (mDNS)
    avahi = {
      enable = true;
      openFirewall = true;
    };
  };
}
