{ config, pkgs, lib, ... }:
{
  options.modules.bluetooth.enable = lib.mkEnableOption "bluetooth";
  config = lib.mkIf config.modules.bluetooth.enable {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
    hardware.pulseaudio = {
      enable = true;
      # NixOS allows either a lightweight build (default) or full build of
      # PulseAudio to be installed. Only the full build has Bluetooth support, so
      # it must be selected here.
      package = pkgs.pulseaudioFull;
    };
  };
}
