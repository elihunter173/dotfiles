#!/usr/bin/env sh

# A collection of standard aliases, bookmarks, and functions always sourced by
# my interactive shells.

# Tell GNUPG to use the terminal and no GUI
export GPG_TTY=$(tty)

# Pick the one true editor
if command -v nvr > /dev/null && [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR='nvr -cc FloatermHide'
elif command -v code > /dev/null && [ "$TERM_PROGRAM" = "vscode" ]; then
    export EDITOR='code'
elif command -v nvim > /dev/null; then
    export EDITOR='nvim'
elif command -v vim > /dev/null; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

# The defaults are good IMO
unset LS_COLORS
alias l='ls'
alias ll='ls -lh'
alias la='ls -a'
command -v tree > /dev/null && alias lt="tree"
alias ls='ls --color=auto -F'

# Quick shortcuts
alias e="$EDITOR"
alias g='git' # further shortcuts in ~/.gitconfig

if command -v xdg-open > /dev/null; then
    alias o='xdg-open'
fi

# I have issues with xterm-termite cross platform
if [[ $TERM == xterm-termite ]]; then
    export TERM='xterm-256color'
fi

# Bookmarks
export TRASH="$HOME/.local/share/Trash/files"
export ARC="$HOME/src/arc"
export NOTES="$HOME/Documents/notes"
