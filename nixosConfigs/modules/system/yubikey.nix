{ pkgs, ... }:

{
  hardware.gpgSmartcards.enable = true;

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  # Yubico's official tools
  environment.systemPackages = [
    pkgs.yubikey-manager
  ];
}
