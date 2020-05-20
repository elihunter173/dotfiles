{ config, options, lib, ... }:

{
  imports = [
    ./awesome.nix
    ./i3.nix
    ./sway.nix
    ./steam.nix
  ];

  options = {
    my = {
      username = lib.mkOption { type = lib.types.str; };
    };
  };
}
