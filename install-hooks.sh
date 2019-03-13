#!/usr/bin/env sh

# Recursively runs all 'process-config.sh' files in and below the current
# directory. Also sets wallpaper using feh.
#
# Author: Eli W. Hunter

# ANSI color shortcuts
HEADER_COLOR="\u001b[35m"
COMMAND_COLOR="\u001b[36m"
NORMAL_COLOR="\u001b[0m"

# Text shortcuts
PREFIX='==> '

# Echos the given text as a header. A command is in the HEADER_COLOR with
# PREFIX as a prefix.
# Args: The text to print.
print_header() {
    printf "$HEADER_COLOR"
    printf "${PREFIX}$@\n"
    printf "$NORMAL_COLOR"
    echo
}

# Echos the given text as a command. A command is in the COMMAND_COLOR.
# Args: The text to print.
print_command() {
    printf "$COMMAND_COLOR"
    printf "$@\n"
    printf "$NORMAL_COLOR"
}

print_header "Starting custom install hooks"

# Execute all process-config scripts
for program in $(ls | grep --invert-match 'deprecated'); do
    for script in $(find "$program" -name 'process-config.sh'); do
        print_command "Processing ${program} config"
        $script
        echo
    done
done

if command -v feh &> /dev/null; then
    print_command "Setting wallpaper"
    feh --bg-fill "${HOME}/Pictures/wallpaper"
    echo
fi

print_header "All custom install hooks executed successfully"

printf "Don't forget to run etc/export.sh!\n"
