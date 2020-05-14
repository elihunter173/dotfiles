# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./host-specific.nix
    ./modules
  ];

  # I'm a bad person
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Automated location data because I move around
  location.provider = "geoclue2";

  modules = {
    awesome.enable = true;
    i3.enable = true;
    i3.default = true;
    sway.enable = true;
  };

  boot.plymouth.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    neovim
    gnvim
    alacritty
    discord
    steam
    vlc
    spotify
    firefox
    libnotify

    # CLI Tools
    git
    tmux
    htop
    fd
    ripgrep
    exa
    nmap
    direnv  # for lorri
    xclip
    ctags
    entr
    pdftk
    texlive.combined.scheme-basic
    zip
    unzip
    hyperfine

    plover.dev

    # Python
    (python3.withPackages (ps: with ps; [
      # Development
      ipython
      flake8
      mypy
      black
      isort
      python-language-server
      pyls-mypy
      pyls-black
      pyls-isort
      # Math
      jupyterlab
      numpy
      sympy
    ]))
    # ensure-pip has problems if you add this as a package to python
    poetry

    # C/C++
    clang-tools
    man-pages

    # Lua
    lua
  ];

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      hack-font
      noto-fonts-emoji
      font-awesome-ttf
      twemoji-color-font
    ];
    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Hack" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  programs.zsh = {
    enable = true;
    # I use my own prompt init
    promptInit = "";
  };

  # List services that you want to enable:
  services = {
    openssh.enable = true;
    lorri.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # TODO: Should I do this? Also, need to add group to my user. Maybe make this
  # a module?
  networking.networkmanager.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # For steam support
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eli = {
    isNormalUser = true;
    extraGroups = [
      "wheel"  # sudo
      "networkmanager"  # network manager is enabled
    ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
