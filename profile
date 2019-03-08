# vim: filetype=sh
# Source this machine's special config
source "${HOME}/.envars"

# The path to my source code folder
export SRC="${HOME}/src"

# Tells GNUPG the terminal to use for everything
export GPG_TTY=$(tty)

if command -v go; then
    # Make ~ my GOPATH (e.g. ~/src and ~/bin)
    export GOPATH="$HOME"
    # Add my GOPATH bin to PATH for Go programs
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# Add local binary files (used by python)
export PATH="$PATH:$HOME/.local/bin"

if command -v ruby; then
    # Add Ruby Gems to PATH for Ruby programs/gems
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    # Allows the user to install rubygems
    export GEM_HOME=$HOME/.gem
fi

# My custom scripts
export PATH=$PATH:$HOME/.scripts

# Standard Monitors (used by WMs and Xorg)
export MAIN_MONITOR='eDP1'
export RIGHT_MONITOR='HDMI2'
export LEFT_MONITOR='HDMI1'

## Xorg Config ##
# Turn off annoying bell
xset -b b off

# Display Power Management Settings
#         standby suspend off
xset dpms 600     900     1800

# Screen Saver Settings
#      timeout cycle
xset s 300     0
