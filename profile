#!/usr/bin/env sh
# Add local binary files (used by pip)
export PATH="$PATH:$HOME/.local/bin"

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

if command -v cargo > /dev/null; then
    export PATH="$PATH:$HOME/.cargo/bin"
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

if command -v nnn > /dev/null; then
    export NNN_USE_EDITOR=1
fi

if [ -d "$HOME/.linuxbrew" ]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
fi

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"
# To support multiple glibcLocales, nixpkgs patches everything which uses them
# to look at LOCALE_ARCHIVE
# https://nixos.org/nixpkgs/manual/#locales
[ -e "$HOME/.nix-profile/lib/locale" ] && export LOCALE_ARCHIVE="$(readlink ~/.nix-profile/lib/locale)/locale-archive"
