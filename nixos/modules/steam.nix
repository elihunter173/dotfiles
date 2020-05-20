{ config, pkgs, lib, ... }:

{
  options.modules.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf config.modules.steam.enable {
    environment.systemPackages = with pkgs; [
      steam
    ];
    # For steam support
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    hardware.pulseaudio.support32Bit = true;
  };
}
