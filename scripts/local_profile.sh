eval "$(/opt/homebrew/bin/brew shellenv)"

export GITLAB_TOKEN=$(security find-generic-password -a ${USER} -s gitlab_token -w)
