#!/usr/bin/env sh

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    cat >&2 << EOF
This script syncs a local directory to rclone's eos profile for the current user.
The directory is synced at the home directory using the basename of the local directory.

Usage: $0 LOCAL_PATH RCLONE_REMOTE [REMOTE_PATH]

Args:
    LOCAL_PATH: The local path to be the reference for the remote.
    RCLONE_REMOTE: The rclone remote to be synced to.
    REMOTE_PATH: The path to directory in the remote.
EOF
    exit 1
fi

# Set up log file
echo "*** LOG \`$@\` ($(date)) ***"

# Parse Arguments
LOCAL_PATH="$1"
# If REMOTE_PATH ($3) is empty, it has no effect.
REMOTE_DEST="${2}:${3}/$(basename "$LOCAL_PATH")"

# Create sync alias for easier maintenance across the different branches.
# -vv (very verbose) flag is for debugging
# --transfers describes how many files can be created in parrallel
# --links document symlinks but don't copy
alias sync="rclone sync -vv --transfers 16 --links"

if [ -f "$LOCAL_PATH/rclone-exclude.txt" ]; then
    # If the exclude file exists, use it
    sync --exclude-from "$LOCAL_PATH/rclone-exclude.txt" --delete-excluded \
        "$LOCAL_PATH" "$REMOTE_DEST"
else
    # Otherwise, don't
    sync "$LOCAL_PATH" "$REMOTE_DEST"
fi
