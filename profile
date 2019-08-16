#!/usr/bin/env sh
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
