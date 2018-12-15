# This file contains all of the core envars and keybindings required by all other scripts

# always recompile config upon restart
exec_always "~/.config/i3/process-config.sh"

# LAYERS
# TODO: deprecate $mod
set $mod Mod4
set $primary_action Mod4
set $secondary_action Mod4+Shift
set $app_bindings Ctrl+Shift

# MISC KEYS
# set the standard direction keys when arrow keys are not used (vim keys!)
set $up k
set $down j
set $left h
set $right l

# CORE KEYBINDINGS
# reload config
bindsym $secondary_action+c exec ~/.config/i3/process-config.sh; reload
# restart i3 inplace (exec_always already recompiles)
bindsym $secondary_action+r restart
