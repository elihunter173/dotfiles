#!/usr/bin/env sh

# TODO: Use different colors for different meanings. For example, have
# check_for display messages in a warning color

# Set up so we always print our desired color
WARN="\u001b[31m"
OKAY="\u001b[34m"
RESET="\u001b[0m"
trap 'printf "$RESET"' EXIT

# usage: try_install BIN [COMMANDS...]
#
# Attempts to install BIN if it is not already present by running one of
# COMMANDS. The user is presented each COMMAND in order and asked if they would
# like to run it. After they run one command, we don't try any others.
#
# If no COMMANDS are given or the BIN couldn't be installed due to a command
# failing, a warning is issued
function try_install() {
  bin="$1"
  # We pop $1 off of $@, making $@ the commands we want to install. We can't
  # assign it to a variable because that causes issues with string
  # separation.
  shift
  if command -v "$bin" &>/dev/null; then
    printf "$OKAY"
    echo "'$bin' already installed. Skipping..."
    return
  fi

  for cmd in "$@"; do
    printf "$OKAY"
    printf "Install '$bin' with '$cmd'? (y/N) "
    read response
    case "$response" in
      ([Yy])
        if eval "$cmd"; then
          return
        else
          printf "$WARN"
          echo "'$cmd' failed!"
          break
        fi
        ;;
    esac
  done

  printf "$WARN"
  echo "'$bin' couldn't be found and is recommended!"
}

try_install 'starship' 'cargo install starship' 'curl -fsSL https://starship.rs/install.sh | bash'
try_install 'direnv'
try_install 'nvim'
