### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

has() {
  command -v "$1" > /dev/null
  return $?
}

# Tell GNUPG to use the terminal and no GUI
export GPG_TTY=$(tty)

if has nvr && [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export EDITOR='nvr -cc FloatermHide'
elif has code && [ "$TERM_PROGRAM" = vscode ]; then
    export EDITOR='code'
elif has nvim; then
    export EDITOR='nvim'
elif has vim; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

has fd && export FZF_DEFAULT_COMMAND='fd --type f'

# The defaults are good IMO
unset LS_COLORS
alias l='ls'
alias ll='ls -lh'
alias la='ls -a'
has tree && alias lt='tree'
alias ls='ls --color=auto -F'

# Quick shortcuts
alias e="$EDITOR"
alias g='git' # further shortcuts in ~/.gitconfig
alias o='xdg-open'

# I have issues with xterm-termite cross platform
if [[ $TERM == xterm-termite ]]; then
    export TERM='xterm-256color'
fi

if [[ $TERM == xterm-kitty ]]; then
    alias icat='kitty +kitten icat'
    # xterm-kitty isn't supported everywhere
    alias ssh='TERM=xterm-256color ssh'
fi

# I'm a traitor in the shell. I like emacs bindings there
bindkey -e

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

# Do ROS setup
if [[ -f /opt/ros/melodic/setup.zsh ]]; then
  source /opt/ros/melodic/setup.zsh
fi

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
