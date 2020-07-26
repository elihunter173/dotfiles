{ config, pkgs, lib, ... }:
{
  options.modules.rust.enable = lib.mkEnableOption "rust";
  config = lib.mkIf config.modules.rust.enable {
    environment.systemPackages = with pkgs; [
      rustup
      clang
      rust-analyzer
      llvmPackages.bintools
      cargo-udeps
      cargo-audit
    ];
  };
}
