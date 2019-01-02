PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin" # Adds rubygem to current PATH
export GEM_HOME=$HOME/.gem # Allows the user to install rubygems

# Neovim is the best editor ;)
EDITOR=/usr/bin/nvim

# set the umask to be more secure
umask 027

# for gpg
export GPG_TTY=$(tty)
