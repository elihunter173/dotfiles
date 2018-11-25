# `command -v` prints out the version of `command`. This can be used to check if something exists.
# /dev/null is a standard dumping ground for stdout. 2>&1 reroutes stderr to stdout.

# Sets vim to start neovim if vim isn't installed. Neovim is better anyway ;)
vim --version >/dev/null 2>&1 || alias vim='nvim'

alias l.='ls -d .*'
