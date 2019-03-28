#!/usr/bin/env sh
# vim: foldmethod=marker
# Quick shortcuts
alias o="_easy_open"
alias e="$EDITOR"

# Make rm safe
if command -v safe-rm > /dev/null; then
    alias rmm="/bin/rm"
    alias rm="safe-rm"
fi

# Utilities
alias la="ls -lAh .*"
alias l.="ls -ld .*"

alias grepp="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} --line-number --with-filename --context=1"

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
alias gs="git stash save"
alias gsp="git stash pop"
