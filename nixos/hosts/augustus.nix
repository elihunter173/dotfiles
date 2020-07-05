{ config, pkgs, lib, ... }:

{
  modules = {
    sway.enable = true;
    steam.enable = true;
    docker.enable = true;
    bluetooth.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;

  services.xserver.libinput = {
    enable = true;
    # disableWhileTyping = true;
    middleEmulation = false;
    tapping = false;
  };
}
