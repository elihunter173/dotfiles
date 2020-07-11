{ config, options, lib, ... }:
{
  imports = [
    ./bluetooth.nix
    ./docker.nix
    ./i3.nix
    ./rclone.nix
    ./steam.nix
    ./sway.nix
  ];

  options = {
    my = {
      username = lib.mkOption { type = lib.types.str; };
    };
  };
}
