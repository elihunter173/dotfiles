#!/usr/bin/env sh

# A collection of standard aliases, bookmarks, and functions always sourced by
# my shells.

# Quick shortcuts
alias e="$EDITOR"
alias g="git" # further shortcuts in ~/.gitconfig

# Cleaner ls
alias ls="ls --color=auto"
alias la="ls -lAh"
alias l.="ls -ld .*"

# Make rm safe
if command -v safe-rm > /dev/null; then
    alias rmm="/bin/rm"
    alias rm="safe-rm"
fi

# Bookmarks
export TRASH="$HOME/.local/share/Trash/files"
export SRC="$HOME/src"
export ARC="$SRC/arc"
export NOTES="$HOME/Documents/notes"


# Go to a clean, temporary directory to play around in.
play() {
    # Generate a playground directory with 16 random alphanumerics
    play_dir="/tmp/playground-$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 16 | head -n 1)"
    mkdir -p "$play_dir" && cd "$play_dir"
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
