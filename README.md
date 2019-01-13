# Eli's Dotfiles

This repository serves as a storage for all my config files, making it easier to
set up and maintain my setup across multiple computers. Feel free to read through
and copy as you wish!

This is managed by [Dotbot](https://git.io/dotbot).

## Layers?

Whenever a config file becomes sufficiently long or there are plugins involved,
I implement layers. If the program supports layers natively (e.g. zsh and nvim),
I implement it as supported. However, if the program does not, I create a script
that automatically processes the layers and outputs the appropriate config file.

Each layer is a directory that consists of a file that describes all the plugins
associated with that layer, where applicable, and a file that describes all the
specific config associated with that layer.

Each layer should be non-redundant and completely orthogonal from all others,
meaning that it has no dependencies on the contents of any other layer.

This modularizes my config and makes navigation and modification easier. Feel
free to tear out entire layers and swap them out for others as you wish!

## Features

* Only somewhat outdated documentation!
* Pretty [base16](https://github.com/chriskempson/base16) colors

### Shell

* (Oh My) Zsh!
* Auto-completion
* Syntax highlighting
* Easier `sudo`!

### Vim

* TBD

### Misc.

* Default umask `027` for moderate security.

## Setup Notes

* Edit `/etc/default/tlp` to set power settings
