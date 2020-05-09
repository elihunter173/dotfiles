{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;

  networking = {
    hostName = "tiberius";
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      # Ethernet
      enp3s0 = {
        ipv4.addresses = [ {
          address = "192.168.2.20";
          prefixLength = 24;
        } ];
        # We use a static IP but also have all the good dynamic stuff
        useDHCP = true;
      };
      # Wifi
      wlp2s0.useDHCP = true;
    };
  };
}
