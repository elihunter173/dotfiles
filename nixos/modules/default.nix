{ config, options, lib, ... }:
{
  imports = [
    ./bluetooth.nix
    ./creativeTools.nix
    ./docker.nix
    ./documents.nix
    ./i3.nix
    ./python.nix
    ./rclone.nix
    ./rust.nix
    ./steam.nix
    ./sway.nix
  ];

  options = {
    my = {
      username = lib.mkOption { type = lib.types.str; };
    };
  };
}
