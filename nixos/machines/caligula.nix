{ config, pkgs, lib, ... }:

{
  modules = {
    i3.enable = true;
    steam.enable = true;
    docker.enable = true;

    python.enable = true;
    rust.enable = true;

    creativeTools.enable = true;
    documents.enable = true;

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
        { path1 = "%h/Documents/arc_shared"; path2 = "ARC:/"; }
      ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = true;

  # I'd use nouveau with sway, but it keeps crashing :(
  services.xserver.videoDrivers = [ "nvidia" ];

  services.openssh.enable = true;

  location = {
    latitude = 36.01262;
    longitude = -80.37556;
  };
}
