{ config, pkgs, lib, ... }:

{
  modules = {
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp3s0 = {
        useDHCP = true;
        ipv4.addresses = [ {
          address = "192.168.2.20";
          prefixLength = 24;
        } ];
      };
    };
  };
}
