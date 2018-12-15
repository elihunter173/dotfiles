PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin" # Adds rubygem to current PATH
export GEM_HOME=$HOME/.gem # Allows the user to install rubygems

EDITOR=/usr/bin/nvim
