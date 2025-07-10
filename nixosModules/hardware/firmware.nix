{ config, ... }:
{
  # firmware updater for machine hardware
  services.fwupd = {
    enable = true;
  };
}
