{ config, pkgs, lib, ... }:

{
  modules = {
    sway.enable = true;
    steam.enable = true;
    docker.enable = true;
    bluetooth.enable = true;
    rclone = {
      enable = true;
      paths = [
        # { src = "~/Documents/ncsu"; dest = "gdrive:/ncsu"; }
      ];
    };
  };

  # augustus dual boots Ubuntu so we have to boot using grub
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    version = 2;
    useOSProber = true;
  };

  hardware.cpu.intel.updateMicrocode = true;

  services.xserver.libinput = {
    enable = true;
    # disableWhileTyping = true;
    middleEmulation = false;
    tapping = false;
  };
}
