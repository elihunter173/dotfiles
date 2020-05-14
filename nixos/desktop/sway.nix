{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox-wayland

    brightnessctl
    playerctl

    # Menu
    j4-dmenu-desktop
    bemenu
  ];

  programs.sway.enable = true;

  # Ripped from https://nixos.wiki/wiki/Sway.
  # TODO: Fix this
  # TODO: Remove when this becomes standard
  systemd.user.services.sway = {
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # TODO: Is this necessary?
  services.xserver = {
    enable = false;
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = false;
  };
}
