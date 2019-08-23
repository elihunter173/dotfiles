#!/usr/bin/env sh

if [ "$#" -ne 0 ]; then
    cat >&2 << EOF
Cleans all logs in the ~/log directory.

Usage: $0
EOF
    exit 1
fi

# I can't put this in quotes because then * isn't treated as a glob
rm $HOME/log/*.log
