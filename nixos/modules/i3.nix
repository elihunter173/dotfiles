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
          lightdm.autoLogin.enable = true;
          # TODO: Make it so this is read from some user config
          lightdm.autoLogin.user = "eli";
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            betterlockscreen
            xss-lock
            dunst
            picom
            blueman

            flameshot
            feh
            zathura
            arandr
            rofi
            networkmanagerapplet
            playerctl

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
    };
  };
}
