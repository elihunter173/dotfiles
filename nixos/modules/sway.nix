{ config, pkgs, lib, ... }:

{
  options.modules.sway.enable = lib.mkEnableOption "sway";
  config = lib.mkIf config.modules.sway.enable {

    # TODO: Figure out autostart
    # TODO: Move things to be services

    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [
        xwayland
        swaylock
        swayidle
        i3status
        mako
        wdisplays
        wl-clipboard

        lxappearance
        materia-theme
        capitaine-cursors
        papirus-icon-theme

        brightnessctl
        j4-dmenu-desktop
        bemenu
        # Ripped from https://github.com/NixOS/nixpkgs/compare/master...evils:sway-contrib
        (with pkgs; stdenv.mkDerivation rec {
          pname = "grimshot";
          version = "2020-05-08";
          rev = "b1d08db5f5112ab562f89564825e3e791b0682c4";

          # master has new fixes and features, and a man page
          # after sway-1.5 these may be switched to sway-unwrapped.src
          bsrc = fetchurl {
            url = "https://raw.githubusercontent.com/swaywm/sway/${rev}/contrib/grimshot";
            sha256 = "1awzmzkib8a7q5s78xyh8za03lplqfpbasqp3lidqqmjqs882jq9";
          };
          msrc = fetchurl {
            url = "https://raw.githubusercontent.com/swaywm/sway/${rev}/contrib/grimshot.1";
            sha256 = "191xxjfhf61gkxl3b0f694h0nrwd7vfnyp5afk8snhhr6q7ia4jz";
          };

          nativeBuildInputs = [ makeWrapper ];

          phases = [ "installPhase" "fixupPhase" "checkPhase" ];

          installPhase = ''
            install -D ${msrc} $out/share/man/man1/grimshot.1
            install -Dm 0755 ${bsrc} $out/bin/grimshot
            wrapProgram $out/bin/grimshot --set PATH \
            "${stdenv.lib.makeBinPath [
              sway-unwrapped
              wl-clipboard
              coreutils
              libnotify
              slurp
              grim
              jq
            ]}"
          '';

          doCheck = true;

          checkPhase = "$out/bin/grimshot check";

          meta = with stdenv.lib; {
            description = "A helper for screenshots within sway";
            homepage = "https://github.com/swaywm/sway/tree/master/contrib";
            license = licenses.mit;
            platforms = platforms.all;
            maintainers = [ maintainers.evils ];
          };
        })
      ];
    };
  };
}
