# `command -v` prints out the version of `command`. This can be used to check if something exists.
# /dev/null is a standard dumping ground for stdout. 2>&1 reroutes stderr to stdout.

alias rmm="/bin/rm" # make rmm the true rm
alias rm="~/.zshrc.d/scripts/safe-rm" # make rm safe

# enable listing all dot files
alias l.='ls -d .*'

# set vim to neovim if vim isn't installed. it's bettery anyway ;)
vim --version >/dev/null 2>&1 || alias vim='nvim'

# enable 'Light Vim'
alias lvim='nvim -u ~/.lvimrc'
