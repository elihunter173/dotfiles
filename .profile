#!/usr/bin/env sh

# Add local binary files (also used by pip)
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export STEEL_HOME="$HOME/.config/steel"

# Qt5
export QT_QPA_PLATFORMTHEME=qt5ct

# Connect to ssh-agent running as systemd user service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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

if [ -d "$HOME/.dotnet" ]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi

# Setup ghc and cabal
if [ -d "$HOME/.ghcup" ]; then
    export PATH="$PATH:$HOME/.ghcup/bin"
fi
if [ -d "$HOME/.cabal" ]; then
    export PATH="$PATH:$HOME/.cabal/bin"
fi

# Add go installation to path
export PATH="$PATH:/usr/local/go/bin"

export ZK_NOTEBOOK_DIR="$HOME/zk"

export TRASH="$HOME/.local/share/Trash/files"
