for script in ~/.zshrc.d/*.zsh; do
    . $script
done

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/eli/.oh-my-zsh"

# Sets the oh-my-zsh theme.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes for more themes.
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Controls which plugins are loaded.
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  archlinux
  colored-man-pages
  colorize
)

# Load the oh-my-zsh shell script
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##########################################################
#   _  _   __   ____  __   __   ____  __    ____  ____   #
#  / )( \ / _\ (  _ \(  ) / _\ (  _ \(  )  (  __)/ ___)  #
#  \ \/ //    \ )   / )( /    \ ) _ (/ (_/\ ) _) \___ \  #
#   \__/ \_/\_/(__\_)(__)\_/\_/(____/\____/(____)(____/  #
#                                                        #
##########################################################


GPG_TTY=$(tty) # For KDEWallet


##############################################
#    __   __    __   __   ____  ____  ____   #
#   / _\ (  )  (  ) / _\ / ___)(  __)/ ___)  #
#  /    \/ (_/\ )( /    \\___ \ ) _) \___ \  #
#  \_/\_/\____/(__)\_/\_/(____/(____)(____/  #
#                                            #
##############################################

# `command -v` prints out the version of `command`. This can be used to check if something exists.
# /dev/null is a standard dumping ground for stdout. 2>&1 reroutes stderr to stdout.

# Sets vim to start neovim if vim isn't installed. Neovim is better anyway ;)
vim --version >/dev/null 2>&1 || alias vim='nvim'
