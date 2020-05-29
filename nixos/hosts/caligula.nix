{ config, pkgs, lib, ... }:

{
  modules = {
    i3.enable = true;
    steam.enable = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;

  # I'd use nouveau with sway, but it keeps crashing :(
  services.xserver.videoDrivers = [ "nvidia" ];
}
