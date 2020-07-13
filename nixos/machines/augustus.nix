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
        { path1 = "%h/Documents/arc"; path2 = "ewhunter:/arc"; }
        { path1 = "%h/Documents/cms"; path2 = "ewhunter:/cms"; }
        { path1 = "%h/Documents/fun_stuff"; path2 = "ewhunter:/fun_stuff"; }
        { path1 = "%h/Documents/ncsu"; path2 = "ewhunter:/ncsu"; }
        { path1 = "%h/Documents/personal"; path2 = "ewhunter:/personal"; }
        { path1 = "%h/Documents/textbooks"; path2 = "ewhunter:/textbooks"; }
        { path1 = "%h/Documents/wfhs"; path2 = "ewhunter:/wfhs"; }
        { path1 = "%h/Pictures"; path2 = "ewhunter:/Pictures"; }
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
