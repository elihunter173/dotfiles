# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Automatically set up zsh4humans if it doesn't exist already
if ! command -v z4h >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

# I don't like pushd all the time
unsetopt AUTO_PUSHD

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# # Autoload functions.
# autoload -Uz zmv

# # Define named directories: ~w <=> Windows home directory on WSL.
# [[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias k='kubectl'
alias ls='ls --classify --color'

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Installed zsh-abbr via homebrew https://zsh-abbr.olets.dev/installation.html
# ```
# To activate abbreviations, add the following at the end of your .zshrc:
#
#     source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh
# "kn"="--namespace"
# "knb"="--namespace busly"
# "knbs"="--namespace busly-shadow"
# "knd"="--namespace rtdb-dist"
# "knds"="--namespace rtdb-dist-shadow"
# "knh"="--namespace rtdb-hll"
# "knhs"="--namespace rtdb-hll-shadow"
# "knp"="--namespace rtdb-points"
# "knps"="--namespace rtdb-points-shadow"
# "kx"="--context"
# "kxap1a"="--context brionne-a.ap1.prod.dog"
# "kxap1c"="--context brionne-c.ap1.prod.dog"
# "kxap1d"="--context brionne-d.ap1.prod.dog"
# "kxeu1a"="--context staryu-a.eu1.prod.dog"
# "kxeu1b"="--context staryu-b.eu1.prod.dog"
# "kxeu1c"="--context staryu-c.eu1.prod.dog"
# "kxgov"="--context plain1.us1.fed.dog"
# "kxsa"="--context oddish-a.us1.staging.dog"
# "kxsb"="--context oddish-b.us1.staging.dog"
# "kxsc"="--context oddish-c.us1.staging.dog"
# "kxus1a"="--context metrics1a.us1.prod.dog"
# "kxus1b"="--context metrics1b.us1.prod.dog"
# "kxus1e"="--context metrics1e.us1.prod.dog"
# "kxus31"="--context trotro-1.us3.prod.dog"
# "kxus32"="--context trotro-2.us3.prod.dog"
# "kxus33"="--context trotro-3.us3.prod.dog"
# "kxus5a"="--context zorua-a.us5.prod.dog"
# "kxus5c"="--context zorua-c.us5.prod.dog"
# "kxus5f"="--context zorua-f.us5.prod.dog"
# "c"="cargo"
# "cargo c"="cargo check"
# "cargo t"="cargo test"
# "e"="nvim"
# "g"="git"
# "git a"="git add --verbose --all"
# "git ae"="git add --edit --all"
# "git c"="git commit"
# "git ca"="git commit --amend"
# "git ce"="git commit --amend --no-edit"
# "git cl"="git clone --recurse-submodules"
# "git co"="git checkout"
# "git d"="git diff"
# "git f"="git fetch --prune"
# "git hs"="git hist -20"
# "git l"="git pull --prune"
# "git p"="git push"
# "git pf"="git push --force-with-lease"
# "git rb"="git rebase"
# "git rs"="git restore"
# "git st"="git status"
# "git sw"="git switch"
# "j"="just"
# "k"="kubectl"
# "kg"="kubectl get"
# "kgp"="kubectl get pods"
# "l"="ls"
# "o"="open"
z4h source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

z4h source ~/.config/eli/local_zshrc.zsh

export EDITOR=nvim

# A really expensive command not found handler get inserted somewhere. This overrides it
command_not_found_handler() {
    echo "zsh: command not found: $@"
    return 127
}

function verget() {
  kubectl get pod -o jsonpath='{.metadata.labels.version}' $@
  echo
}

function t() {
  name="$1"
  # I don't use colons because that causes issues with kubectl cp and also
  # messes with a lot of word-breaking stuff
  tmpdir="$HOME/tmp/$name-$(date -u +%Y-%m-%dT%H_%M_%SZ)"
  mkdir -p "$tmpdir"
  pushd "$tmpdir"
}
