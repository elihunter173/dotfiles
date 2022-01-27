#!/usr/bin/env sh

# Add local binary files (used by pip)
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

if command -v poetry > /dev/null; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

if command -v R > /dev/null; then
    export R_LIBS_USER="$HOME/.r"
fi

if command -v go > /dev/null; then
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$HOME/.go/bin"
fi

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

if command -v npm > /dev/null; then
    export PATH="$PATH:$HOME/.npm/bin"
    export NODE_PATH="$NODE_PATH:$HOME/.npm/lib/node_modules"
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

if command -v luarocks > /dev/null; then
    export PATH="$PATH:$HOME/.luarocks/bin"
fi

# Add go installation to path
export PATH="$PATH:/usr/local/go/bin"

export ZK_NOTEBOOK_DIR="$HOME/zk"

export TRASH="$HOME/.local/share/Trash/files"
