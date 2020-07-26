{ config, pkgs, lib, ... }:
{
  options.modules.i3.enable = lib.mkEnableOption "i3";
  config = lib.mkIf config.modules.i3.enable {
    services = {
      autorandr.enable = true;
      redshift = {
        enable = true;
        # Balanced white temperature during day
        temperature.day = 6500;
      };

      # TODO: Move more things to be services?

      xserver = {
        enable = true;
        desktopManager.xterm.enable = false;
        displayManager = {
          defaultSession = "none+i3";
          lightdm.enable = true;
          autoLogin.enable = true;
          # TODO: Make it so this is read from some user config
          autoLogin.user = "${config.my.username}";
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            i3lock
            xss-lock
            dunst
            picom
            flameshot
            arandr
            rofi
            unclutter-xfixes
            # For setting
            feh
            brightnessctl

            # Applets
            blueman
            networkmanagerapplet

            # Theming
            lxappearance
            arc-theme
            capitaine-cursors
            papirus-icon-theme
          ];
        };
      };
    };
  };
}
