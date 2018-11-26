# segment .zshrc.
# numbers are used to control load order.
for script in ~/.zshrc.d/*.zsh; do
    source $script
done

