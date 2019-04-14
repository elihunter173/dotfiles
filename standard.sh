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

# Override shell defaults
alias time="/usr/bin/time "

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
#!/usr/bin/env sh

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

# Counts the number of instances of the given word in the given file, using word
# regex.
#
# ARGS:
#     $1: The word to counted in the given file.
#     $2: The file to count the number of instances of the given word in
_count_word_instances() {
    local count=$(egrep -w "$1" < "$2" -o | wc -l)
    echo "$count"
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
