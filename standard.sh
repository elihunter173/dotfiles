#!/usr/bin/env sh

# A collection of standard aliases, bookmarks, and functions always sourced by
# my interactive shells.

# Tell GNUPG to use the terminal and no GUI
export GPG_TTY=$(tty)

# Pick the one true editor
if command -v nvr > /dev/null && [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    # TODO: Once neovim has proper remote attachment remove neovim-remote (nvr)
    export EDITOR="nvr -s"
elif command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# A more friendly ls
if command -v exa > /dev/null; then
    alias ls="exa"
else
    alias ls="ls --color=auto -p"
fi

# Cleaner ls
alias la="ls -lAh"
alias l.="ls -ld .*"

# Quick shortcuts
alias e="$EDITOR"
alias g="git" # further shortcuts in ~/.gitconfig

# Make rm safe
if command -v trash-cli > /dev/null; then
    alias rmm="/bin/rm"
    alias rm="trash"
fi

# Bookmarks
export TRASH="$HOME/.local/share/Trash/files"
export SRC="$HOME/src"
export ARC="$SRC/arc"
export NOTES="$HOME/Documents/notes"


# Go to a clean, temporary directory to play around in.
play() {
    cd $(mktemp -d)
}

# Destroys all Docker data, reseting it to the cleanest state possible.
docker_destroy() {
    echo "Destroying all docker data..."
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}
