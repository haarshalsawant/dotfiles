{ config, pkgs, username, ... }:

{
  # Sdkmanager
  nixpkgs.config.android_sdk.accept_license = true;

  programs.adb.enable = true;
  users.users.${username}.extraGroups = [ "adbusers" ];
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    # Android
    universal-android-debloater # uad-ng
    sdkmanager
    android-studio
  ];
}
