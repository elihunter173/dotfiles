{ config, pkgs, lib, ... }:
{
  options.modules.docker.enable = lib.mkEnableOption "docker";
  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker.enable = true;
    users.users."${config.my.username}".extraGroups = [ "docker" ];
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
