{ config, pkgs, lib, ... }:
# TODO: Extract this to a general set up
{
  # Overlays for stephano-m's luaModules enabling better pulseaudio control
  nixpkgs.overlays = with builtins; [
    (import (fetchGit {
      url = "https://github.com/stefano-m/nix-stefano-m-nix-overlays";
      ref = "master";
    }))
  ];

  environment.systemPackages = with pkgs; [
    flameshot
    feh
    zathura
    arandr
    rofi

    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.gvfs
    # Required for thunar to store settings
    xfce.xfconf

    lxappearance
    capitaine-cursors
    papirus-icon-theme
    # mojave-gtk-theme

    i3lock
    libnotify
  ];
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
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      xautolock = {
        enable = true;
        killer = "${pkgs.systemd}/bin/systemctl suspend";
        locker = "${pkgs.i3lock}/bin/i3lock";
        notifier = "${pkgs.libnotify}/bin/notify-send -u critical 'Locking in 10 seconds'";
      };
      windowManager.awesome = {
        enable = true;
        # TODO: Figure out how to use luarocks packages
        luaModules = with pkgs.luaPackages; with pkgs.extraLuaPackages; [
          vicious

          # For some reason stephano-m's method of declaring dependencies isn't working
          dbus_proxy
          media_player
        ];
      };
      # Set up autologin
      displayManager = {
        defaultSession = "none+awesome";
        lightdm.enable = true;
        lightdm.autoLogin.enable = true;
        # TODO: Make it so this is read from some user config
        lightdm.autoLogin.user = "eli";
      };
    };
  };
}
