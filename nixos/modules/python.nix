{ config, pkgs, lib, ... }:
{
  options.modules.python.enable = lib.mkEnableOption "python";
  config = lib.mkIf config.modules.python.enable {
    environment.systemPackages = with pkgs; [
      # Python
      (python3.withPackages (ps: with ps; [
        # Development
        virtualenv
        tox
        flake8
        mypy
        black
        isort
        python-language-server
        pyls-mypy
        pyls-black
        pyls-isort
        # Math
        ipython
        jupyterlab
        numpy
        sympy
      ]))
      # ensure-pip has problems if you add this as a package to python
      poetry
    ];
  };
}
