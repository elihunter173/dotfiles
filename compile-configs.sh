#!/usr/bin/env sh

# Recursively runs all 'process-config.sh' files in and below the current
# directory.
#
# Author: Eli W. Hunter

# ANSI color shortcuts
HEADER_COLOR="\u001b[35m"
COMMAND_COLOR="\u001b[36m"
NORMAL_COLOR="\u001b[0m"

printf "$HEADER_COLOR"
printf "\nStarting custom install hooks\n\n"
printf "$NORMAL_COLOR"

# Execute all process-config scripts
for program in $(ls | grep --invert-match 'deprecated'); do
    for script in $(find "$program" -name 'process-config.sh'); do
        printf "$COMMAND_COLOR"
        printf "Processing ${program} config\n"
        printf "$NORMAL_COLOR"
        $script
        echo
    done
done

printf "$HEADER_COLOR"
printf "==> All custom install hooks executed successfully\n"
printf "$NORMAL_COLOR"

printf "\nDon't forget to run etc/export.sh!\n"
