#!/usr/bin/env sh
# vim: filetype=sh

# Eli W. Hunter's generic ~/.profile
# export TERM=xterm-256color

# Find out if you are running remotely
SESSION_TYPE=
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE="remote/ssh"
fi
export SESSION_TYPE

# Source this machine's special config
. "${HOME}/.envars"

# The path to my source code folder
export SRC="${HOME}/src"
# The path to my executable folders
export PATH="$PATH:$HOME/bin"

# Set up Pyenv if present (for Pipenv)
if command -v pyenv > /dev/null; then
    export PYENV_ROOT="$(pyenv root)"
fi

# Tells GNUPG the terminal to use for everything
export GPG_TTY=$(tty)

if command -v go > /dev/null; then
    # Make ~ my GOPATH (e.g. ~/src and ~/bin)
    export GOPATH="$HOME"
    # Add my GOPATH bin to PATH for Go programs
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Add local binary files (used by pip)
export PATH="$PATH:$HOME/.local/bin"

if command -v ruby > /dev/null; then
    # Add Ruby Gems to PATH for Ruby programs/gems
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    # Allows the user to install rubygems
    export GEM_HOME=$HOME/.gem
fi

# If you have Xorg and are running over ssh
if [ -n "$DISPLAY" ] && [ "$SESSION_TYPE" != "remote/ssh" ]; then
    xset -b b off

    # Display Power Management Settings
    #         standby suspend off
    xset dpms 600     900     1800

    # Screen Saver Settings
    #      timeout cycle
    xset s 300     0
fi
