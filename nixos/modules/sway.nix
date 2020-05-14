{ config, options, pkgs, lib, ... }:
# TODO: Is this with needed?
with lib;
{
  options.modules.sway = {
    enable = mkEnableOption "sway";
    default = mkOption {
      default = false;
      type = types.bool;
      description = "Whether sway should be autostarted.";
    };
  };

  config = mkIf config.modules.sway.enable {
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
        playerctl
        networkmanagerapplet
        arandr
      ];
    };

    services.xserver.displayManager = mkIf config.modules.sway.default {
      defaultSession = "sway";
      lightdm.enable = true;
      lightdm.autoLogin.enable = true;
      # TODO: Make it so this is read from some user config
      lightdm.autoLogin.user = "eli";
    };
  };
}
