#!/usr/bin/env bash

set -e

bisync() {
  echo $ rclone bisync "$1" "$2" --exclude-from ~/.config/eli/rclone-exclude --log-level INFO "${@:3}"
  rclone bisync "$1" "$2" --exclude-from ~/.config/eli/rclone-exclude --log-level INFO "${@:3}"
}

bisync ~/Documents/fun_stuff             elihunter173:/fun_stuff             "$@"
bisync ~/Documents/graduate_applications elihunter173:/graduate_applications "$@"
bisync ~/Documents/jobs                  elihunter173:/jobs                  "$@"
bisync ~/Documents/jupyter               elihunter173:/jupyter               "$@"
bisync ~/Documents/ncsu                  elihunter173:/ncsu                  "$@"
bisync ~/Documents/personal              elihunter173:/personal              "$@"
bisync ~/Documents/textbooks             elihunter173:/textbooks             "$@"
# bisync ~/Pictures                        elihunter173:/Pictures              "$@"
# bisync ~/Videos/movies                   elihunter173:/movies                "$@"
