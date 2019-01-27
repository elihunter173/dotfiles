# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# my custom scripts
export PATH=$PATH:$HOME/.scripts
# For ardupilot
export PATH=$PATH:$HOME/ardupilot/Tools/autotest
# For RubyGem executables
export PATH=$PATH:$(ruby -e 'print Gem.user_dir')/bin

arc='/home/eli/src/gerrit/ARC'
TRASH=$HOME/.local/share/Trash
