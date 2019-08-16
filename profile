#!/usr/bin/env sh
# vim: filetype=sh
# The path to my source code folder
export SRC="${HOME}/src"

# Tells GNUPG the terminal to use for everything
export GPG_TTY=$(tty)

# Add local binary files (used by pip)
export PATH="$PATH:$HOME/.local/bin"

if command -v go > /dev/null; then
    export GOPATH="$HOME/.go"
    # Go binaries
    export PATH="$PATH:$HOME/.go/bin"
fi

if command -v cargo > /dev/null; then
    # Cargo binaries
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# Set up Pyenv if present (for Pipenv)
if command -v pyenv > /dev/null; then
    export PYENV_ROOT="$(pyenv root)"
fi

if command -v ruby > /dev/null; then
    # Add Ruby Gems to PATH for Ruby programs/gems
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    # Allows the user to install rubygems
    export GEM_HOME=$HOME/.gem
fi

# If you have X display, set power settings
if [ -n "$DISPLAY" ]; then
    xset -b b off

    # Display Power Management Settings
    #         standby suspend off
    xset dpms 600     900     1800

    # Screen Saver Settings
    #      timeout cycle
    xset s 300     0
fi

# WE POSTPONE TESTING FOR COMMANDS AS LONG AS POSSIBLE TO MAKE SURE OUR $PATH
# IS CORRECT
# The one true editor
if command -v nvr > /dev/null; then
    # I try to use neovim-remote for remote attachment
    # TODO: Once neovim has proper remote attachment remove neovim-remote (nvr)
    export EDITOR="nvr -s"
elif command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
