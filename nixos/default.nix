device: username:
{ config, pkgs, lib, ... }:

{
  networking.hostName = lib.mkDefault device;
  my.username = username;

  imports = [
    ./hardware-configuration.nix
    ./modules
    # Have to put ./hosts in ${} to get absolute path because relative paths
    # don't work for some reason
    "${./hosts}/${device}.nix"
  ];

  # I'm a bad person
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    neovim
    neovim-remote
    gnvim
    alacritty
    discord
    vlc
    spotify
    firefox
    qutebrowser
    libnotify
    slack-term
    weechat

    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.gvfs
    # Required for thunar to store settings
    xfce.xfconf

    feh
    zathura
    # Applets
    blueman
    networkmanagerapplet

    # CLI Tools
    git
    tmux
    htop
    exa
    fd
    ripgrep
    fzf
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
    gnumake
    playerctl

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${config.my.username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"  # sudo
      "networkmanager"  # network manager is enabled
    ];
    shell = pkgs.zsh;
  };
}
