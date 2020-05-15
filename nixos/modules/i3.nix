{ config, pkgs, lib, ... }:
# TODO: Is this with needed?
with lib;
{
  options.modules.i3 = {
    enable = mkEnableOption "i3";
    default = mkOption {
      default = false;
      type = types.bool;
      description = "Whether i3 should be autostarted.";
    };
  };

  config = mkIf config.modules.i3.enable {
    # TODO: Remove these so they are lazily started by i3 instead of
    # greedily started by nixos
    services = {
      picom = {
        enable = true;
        vSync = true;
        shadow = true;
        shadowExclude = [
          # Only put shadows on these window types
          # Read man picom(1) to find all WINDOW_TYPES from the EWMH standard
          # TODO: Make shadows work with rofi
          "! window_type~='(dock|dialog|splash|notify)$'"
        ];
      };
      autorandr.enable = true;
      unclutter.enable = true;
      redshift = {
        enable = true;
        # Balanced white temperature during day
        temperature.day = 6500;
      };
    };

    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          betterlockscreen
          xss-lock

          flameshot
          feh
          zathura
          arandr
          rofi
          networkmanagerapplet

          xfce.thunar
          xfce.thunar-archive-plugin
          xfce.gvfs
          # Required for thunar to store settings
          xfce.xfconf

          lxappearance
          capitaine-cursors
          papirus-icon-theme
        ];
      };
    };

    # Set up autologin
    services.xserver.displayManager = mkIf config.modules.i3.default {
      defaultSession = "none+i3";
      lightdm.enable = true;
      lightdm.autoLogin.enable = true;
      # TODO: Make it so this is read from some user config
      lightdm.autoLogin.user = "eli";
    };
  };
}
