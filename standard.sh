#!/usr/bin/env sh

# A collection of standard aliases, bookmarks, and functions always sourced by
# my shells.

# Quick shortcuts
alias o="_easy_open"
alias e="$EDITOR"

# Make rm safe
if command -v safe-rm > /dev/null; then
    alias rmm="/bin/rm"
    alias rm="safe-rm"
fi

# Utilities
alias ls="ls --color=auto"
alias la="ls -lAh"
alias l.="ls -ld .*"

# Git
alias ga="git add --verbose"
alias gaa="git add --all --verbose"
alias gc="git commit -v"
alias gc!="git commit -v --amend"
alias gcl="git clone --recurse-submodules"
alias gl="git pull"
alias gp="git push"
alias gpd="git push --dry-run"
alias gst="git status"
alias grm="git rm"
alias glg="git lg"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias grhh="git reset HEAD --hard"
alias gco="git checkout"
alias gcm="git checkout master"
alias gb="git branch"
alias gr="git remote"
# Git stash
alias gs="git stash"
alias gsp="git stash pop"

# Misc
export TRASH="$HOME/.local/share/Trash/files"

# Programming
export SRC="$HOME/src"
export ARC="$SRC/arc"

# Notes
export NOTES="$HOME/Documents/notes"
export csc_src="$SRC/coursework/CSC-216"

# Go to a clean, temporary directory to play around in.
play() {
    # Generate a playground directory with 16 random alphanumerics
    play_dir="/tmp/playground-$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 16 | head -n 1)"
    mkdir -p "$play_dir" && cd "$play_dir"
}

# Acts as a wrapper around fuzzy finding directories for the purpose of changing
# to them by piping the results of find into fzf and then echoing what was found
# by fzf.
#
# ARGS:
#     $1: A valid path to a directory If not specified, defaults to the current
#     directory.
_easy_open() {
    # Sets dir to the first argument or the current directory if unspecified.
    local DIR=${1:-.}
    cd $(find "$DIR" -type d | fzf)
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
