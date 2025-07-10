{
  lib,
  ...
}:

{
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkForce "schedutil";
  };
}
