# `command -v` prints out the version of `command`. This can be used to check if something exists.
# /dev/null is a standard dumping ground for stdout. 2>&1 reroutes stderr to stdout.

# enable listing all dot files
alias l.='ls -d .*'

# set vim to neovim if vim isn't installed. it's bettery anyway ;)
vim --version >/dev/null 2>&1 || alias vim='nvim'

# enable 'Light Vim'
alias lvim='nvim -u ~/.lvimrc'

