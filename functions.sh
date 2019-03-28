#!/usr/bin/env sh

# This library of functions is created to be sourced by each shell to provide
# useful utilities. Aliases, or something similar, are recommending to make
# these easier to use
#
# AUTHORS:
#     Eli W. Hunter


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
