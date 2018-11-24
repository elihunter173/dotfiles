# segment .zshrc.
# numbers are used to control load order.
for script in ~/.zshrc.d/*.sh; do
    source $script
done

