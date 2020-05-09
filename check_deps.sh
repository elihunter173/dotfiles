#!/usr/bin/env sh

# Set up so we always print our desired color
WARN="\033[31m"
OKAY="\033[34m"
RESET="\033[0m"
trap 'printf "$RESET"' EXIT

# usage: try_install BIN [COMMANDS...]
#
# Attempts to install BIN if it is not already present by running one of
# COMMANDS. The user is presented each COMMAND in order and asked if they would
# like to run it. After they run one command, we don't try any others.
#
# If no COMMANDS are given or the BIN couldn't be installed due to a command
# failing, a warning is issued
try_install() {
  bin="$1"
  # We pop $1 off of $@, making $@ the commands we want to install. We can't
  # assign it to a variable because that causes issues with string
  # separation.
  shift

  if command -v "$bin" > /dev/null; then
    printf "$OKAY"
    echo "'$bin' already installed. Skipping..."
    return
  fi

  # We don't have it installed, so we loop over and installation commands,
  # exiting with the first one that was agreed to and worked.
  for cmd in "$@"; do
    printf "$OKAY"
    printf "Install '$bin' with '$cmd'? (y/N) "
    read response
    if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
      if eval "$cmd"; then
        return
      else
        # The command we wanted to try failed, so let's quit early
        printf "$WARN"
        echo "'$cmd' failed!"
        break
      fi
    fi
  done

  printf "$WARN"
  echo "'$bin' couldn't be found and is recommended!"
}

try_install 'awesome'
try_install 'direnv'
try_install 'flameshot'
try_install 'nvim'
try_install 'rofi'
try_install 'xautolock'
