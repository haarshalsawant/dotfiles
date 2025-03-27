{ ... 
}:
{
    services = {
      udev = {
        extraRules = ''
          SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
        '';
      };
    };
}