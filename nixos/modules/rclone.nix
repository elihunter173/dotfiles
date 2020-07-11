{ config, pkgs, lib, ... }:
let
  rclonesyncPkg = { stdenv, fetchFromGitHub, makeWrapper, pythonPackages, rclone }: stdenv.mkDerivation {
    name = "rclonesync";
    version = "2.10";
    buildInputs = [
      makeWrapper
      pythonPackages.python
      rclone
    ];
    src = fetchFromGitHub {
      owner = "cjnaz";
      repo = "rclonesync-V2";
      rev = "v2.10";
      sha256 = "08m1gaw88n1drrnp5mcbi9pnxywsm37agdsh7g4z9xgfvs9q40hs";
    };
    installPhase = ''
      runHook preInstall

      # Make sure we point rclone to the right path
      mkdir -p $out/bin/
      makeWrapper $src/rclonesync.py $out/bin/rclonesync.py \
        --set PATH "${stdenv.lib.makeBinPath (with pkgs; [rclone pythonPackages.python])}"

      runHook postInstall
    '';
  };
  rclonesync = pkgs.callPackage rclonesyncPkg {};
in {
  options.modules.rclone.enable = lib.mkEnableOption "rclone";
  options.modules.rclone.paths = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf lib.types.str);
  };
  config = lib.mkIf config.modules.rclone.enable {
    environment.systemPackages = with pkgs; [
      rclone
      rclonesync
    ];
    systemd.user.services.rclonesync = {
      description = "Rclone File Sync";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = map
          ({path1, path2}: "${rclonesync}/bin/rclonesync.py ${path1} ${path2}")
          config.modules.rclone.paths;
      };
    };
    systemd.user.timers.rclonesync = {
      enable = true;
      timerConfig = {
        OnCalendar = "daily";
        Unit = "rclonesync.service";
      };
    };
  };
}
