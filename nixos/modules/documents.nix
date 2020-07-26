{ config, pkgs, lib, ... }:
{
  options.modules.documents.enable = lib.mkEnableOption "documents";
  config = lib.mkIf config.modules.documents.enable {
    environment.systemPackages = with pkgs; [
      pandoc
      texlive.combined.scheme-full
      pdftk
      imagemagick
      libreoffice
    ];
  };
}
