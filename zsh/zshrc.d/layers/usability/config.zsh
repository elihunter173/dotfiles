# `command -v` prints out the version of `command`. This can be used to check if something exists.
# /dev/null is a standard dumping ground for stdout. 2>&1 reroutes stderr to stdout.

# Enable listing all dot files
alias l.='ls -d .*'

# Easy commit signing
alias gc='git commit -v -S'

# Enable easy, fuzzy directory hopping
alias o='cd $(find . -type d | fzf)'

alias gitconfig_patch="$HOME/src/github/gitconfig-patcher/gitconfig-patcher.sh $HOME/.dotfiles/gitconfigs/ncsu"

# Set vim to neovim if vim isn't installed. it's better anyway ;)
vim --version >/dev/null 2>&1 || alias vim='nvim'
