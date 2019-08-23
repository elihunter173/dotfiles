#!/usr/bin/env sh
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

if command -v pyenv > /dev/null; then
    export PYENV_ROOT="$(pyenv root)"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

if command -v yarn > /dev/null; then
    export PATH="$PATH:$HOME/.yarn/bin"
fi

if command -v ruby > /dev/null; then
    # Add Ruby Gems to PATH for Ruby programs/gems
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    # Allows the user to install rubygems
    export GEM_HOME=$HOME/.gem
fi
