# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

GPG_TTY=$(tty) # For KDEWallet

# my custom scripts
export PATH=$PATH:$HOME/.scripts
# For ardupilot
export PATH=$PATH:$HOME/ardupilot/Tools/autotest
# For RubyGem executables
export PATH=$PATH:$(ruby -e 'print Gem.user_dir')/bin

arc=/home/eli/src/git/ARC
TRASH=$HOME/.local/share/Trash

# This was added automatically by oh-my-zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
