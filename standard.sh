#!/usr/bin/env sh

# A collection of standard aliases, bookmarks, and functions always sourced by
# my interactive shells.

# Tell GNUPG to use the terminal and no GUI
export GPG_TTY=$(tty)

# Pick the one true editor
if command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# A more friendly ls
if command -v exa > /dev/null; then
    alias l="exa"
    alias ll="exa --long --header --group --git"
    alias la="exa --all"
    alias lt="exa --tree"
else
    alias l="ls"
    alias ll="ls -lh"
    alias la="ls -a"
    command -v tree > /dev/null && alias lt="tree"
fi
# I put this after, so command doesn't get tricked
alias exa="exa --classify"
alias ls="ls --color=auto --classify"

# Quick shortcuts
alias e="$EDITOR"
# Fugitive is so nice
alias eg="$EDITOR '+:Gstatus\|bd #'"
alias g="git" # further shortcuts in ~/.gitconfig

# I have issues with xterm-termite cross platform
if [[ $TERM == xterm-termite ]]; then
    export TERM=xterm-256color
fi

# Bookmarks
export TRASH="$HOME/.local/share/Trash/files"
export ARC="$SRC/arc"
export NOTES="$HOME/Documents/ncsu/notes"
