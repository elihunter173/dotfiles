{ config, pkgs, lib, ... }:
{
  options.modules.docker.enable = lib.mkEnableOption "docker";
  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker.enable = true;
    users.users."${config.my.username}".extraGroups = [ "docker" ];
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    # By default we're limited to around ~5000 tasks, which means you can only
    # have around 200 concurrent containers. This poses an issue for Codie if
    # she is receiving hundreds of requests in a short amount of time.
    systemd.services.docker-cor.serviceConfig.TasksMax = "infinity";
    systemd.services.docker.serviceConfig.TasksMax = "infinity";
  };
}
