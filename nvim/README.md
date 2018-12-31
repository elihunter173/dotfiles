# Neovim Config

A nice, cleanly layered Neovim config. *This is completely untested on base vim.*

## Layer Specifications

* Each layer is independent of all other layers (except for its parent).
* Each layer describes a specific aspect of Neovim.
* Parent layers are used to group related layers.
* Parent layers do not contain any config files unless more than one of their
  child layers is dependent on that config.
* Each layer contains a `package.vim` and a `config.vim`.
  * `package.vim` is sourced first and is responsible for installing all vim
    plugins.
  * `config.vim` is sourced second and is responsible for all specific config.
