{ config, pkgs, lib, ... }:

{
  options.modules.sway.enable = lib.mkEnableOption "sway";

  config = lib.mkIf config.modules.sway.enable {

    # TODO: Figure out autostart
    # TODO: Move things to be services

    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [
        xwayland
        swaylock
        swayidle
        i3status
        # Menu
        j4-dmenu-desktop
        bemenu
        # System control
        brightnessctl
      ];
    };

    services.pipewire.enable = true;
  };
}
