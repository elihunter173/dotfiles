### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# I'm a traitor in the shell. I like emacs bindings there
bindkey -e
# Tell GNUPG to use the terminal and no GUI
export GPG_TTY=$(tty)

# Utility functions
function texwatch() {
  echo $@ | entr tectonic $@
}
function collate() {
  pdftk A="$1" B="$2" shuffle A Bend-1 output "$3"
}

BOOKMARKS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/eli/bookmarks"
function jump-bookmark() {
  # I use sd at the end because I couldn't get sed character classes to work on MacOS
  if [[ -n "$1" ]]; then
    dest=$(sed -e 's/#.*//g' -e '/^\s*$/d' "$BOOKMARKS_FILE" | grep --fixed-strings "$*:" | sd '[a-zA-Z0-9]+:' '' -p)
  else
    # These options were taken from
    # https://github.com/junegunn/fzf/blob/e4c3ecc57e99f4037199f11b384a7f8758d1a0ff/shell/key-bindings.zsh#L49
    dest=$(sed -e 's/#.*//g' -e '/^\s*$/d' "$BOOKMARKS_FILE" | fzf --height='40%' --reverse --bind=ctrl-z:ignore | sd '[a-zA-Z0-9]+:' '' -p)
  fi
  if [[ -z "$dest" ]]; then
    guess=$(sed -e 's/#.*//g' -e '/^\s*$/d' "$BOOKMARKS_FILE" | fzf --filter "$1" | head -1 | sd ':.*' '' -p)
    if [[ -n "$guess" ]]; then
      echo "No such bookmark '$1'. Did you mean '$guess'?" >&2
    else
      echo "No such bookmark '$1'." >&2
    fi
    return 1
  fi

  cd ${dest/#\~/$HOME}
}

function in() {
  t=$1
  shift
  (sleep $t && say $@) &
}

if [[ $commands[code] ]] && [ "$TERM_PROGRAM" = vscode ]; then
    export EDITOR='code'
elif [[ $commands[floaterm] ]]; then
    export EDITOR='floaterm'
elif [[ $commands[nvim] ]]; then
    export EDITOR='nvim'
elif [[ $commands[vim] ]]; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

# I have issues with xterm-termite cross platform
if [[ $TERM == xterm-termite ]]; then
    export TERM='xterm-256color'
fi
if [[ $TERM == xterm-kitty ]]; then
    alias icat='kitty +kitten icat'
    # xterm-kitty isn't supported everywhere
    alias ssh='TERM=xterm-256color ssh'
fi

[[ $commands[fd] ]] && export FZF_DEFAULT_COMMAND='fd --type f'

# Quick shortcuts
if [[ $commands[exa] ]]; then
  alias l='exa --classify'
  alias ll='l --long --header'
  alias la='l --all'
else
  alias l='ls --color=auto -F'
  alias ll='l -lh'
  alias la='l -a'
fi

if [[ $commands[wsl-open] ]]; then
  alias o='wsl-open'
elif [[ $commands[open] ]]; then
  alias o='open'
else
  alias o='xdg-open 2>/dev/null'
fi

alias bm='jump-bookmark'
alias c='cargo'
alias d='rip'
alias e="$EDITOR"
alias g='git' # further shortcuts in ~/.config/git/config
alias j='just'

alias kn='kubens'
alias kx='kubectx'
function k() {
  context=$(kubectx --current)
  namespace=$(kubens --current)
  printf '\033[1mkubectl --context %s --namespace %s %s\033[m\n' "$context" "$namespace" "$*"
  kubectl --context "$context" --namespace "$namespace" $@
}

# Easier history searching
# This has issues if you turbo load
zinit light zsh-users/zsh-history-substring-search
bindkey 'OA' history-substring-search-up
bindkey 'OB' history-substring-search-down
bindkey '^P'   history-substring-search-up
bindkey '^N'   history-substring-search-down

# Add syntax highlighting. We zpcompinit and zcpdreplay at init because syntax
# highlighters expect to be loaded last
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
zinit light zsh-users/zsh-syntax-highlighting

# Turbo load more completions. Use blockf and zinit creinstall to use zinit
# to handle completions
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# These cannot be turboloaded because they don't work as expected
zinit for \
  jreese/zsh-titles \
  OMZ::lib/completion.zsh \
  OMZ::lib/history.zsh \
  OMZ::lib/key-bindings.zsh

# Load nice prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
# Magenta and red are hard to tell apart
zstyle :prompt:pure:prompt:success color blue

zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'
zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh'

comp_path="$HOME/.zinit/completions"
[[ ! -f "$comp_path/_kubectl" && $commands[kubectl] ]] && kubectl completion zsh > "$comp_path/_kubectl"
[[ ! -f "$comp_path/_just" ]] && just --completions zsh > "$comp_path/_just"

[[ -f ~/.config/eli/local_zshrc.zsh ]] && source ~/.config/eli/local_zshrc.zsh || true
