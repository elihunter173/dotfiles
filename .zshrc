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
  if [[ -n "$1" ]]; then
    bookmark=$(sed -e 's/#.*//g' -e '/^\s*$/d' "$BOOKMARKS_FILE" | grep --fixed-strings "$*:" | sed 's/[-_ a-zA-Z0-9]\+://')
  else
    # These options were taken from
    # https://github.com/junegunn/fzf/blob/e4c3ecc57e99f4037199f11b384a7f8758d1a0ff/shell/key-bindings.zsh#L49
    bookmark=$(sed -e 's/#.*//g' -e '/^\s*$/d' "$BOOKMARKS_FILE" | fzf --height='40%' --reverse --bind=ctrl-z:ignore | sed 's/[-_ a-zA-Z0-9]\+://')
  fi
  if [[ -z "$bookmark" ]]; then
    echo "No such bookmark '$*'" >&2
    return 1
  fi

  cd ${bookmark/#\~/$HOME}
}

has() {
  command -v "$1" > /dev/null
  return $?
}

if has code && [ "$TERM_PROGRAM" = vscode ]; then
    export EDITOR='code'
elif has nvim && [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR='nvim --server $NVIM_LISTEN_ADDRESS --remote --cmd FloatermHide'
elif has nvim; then
    export EDITOR='nvim'
elif has vim; then
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

has fd && export FZF_DEFAULT_COMMAND='fd --type f'

# Quick shortcuts
if has exa; then
  alias l='exa --classify'
  alias ll='l --long --header'
  alias la='l --all'
else
  alias l='ls --color=auto -F'
  alias ll='l -lh'
  alias la='l -a'
fi

if has wsl-open; then
  alias o='wsl-open'
else
  alias o='xdg-open 2>/dev/null'
fi

alias d='rip'
alias e="$EDITOR"
alias g='git' # further shortcuts in ~/.config/git/config
alias j='jump-bookmark'
alias p='pueue'

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
