{ config, pkgs, lib, ... }:
{
  options.modules.creativeTools.enable = lib.mkEnableOption "creativeTools";
  config = lib.mkIf config.modules.creativeTools.enable {
    environment.systemPackages = with pkgs; [
      # Art
      krita
      gimp
      # Video
      obs-studio
      openshot-qt
      # Audio
      audacity
    ];
  };
}

