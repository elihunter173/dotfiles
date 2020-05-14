{ config, options, lib, ... }:

{
  imports = [
    ./awesome.nix
    ./i3.nix
    ./sway.nix
  ];
}
