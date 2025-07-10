{
  services = {
    printing = {
      enable = true;
      openFirewall = true;
    };

    # Avahi (mDNS)
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
