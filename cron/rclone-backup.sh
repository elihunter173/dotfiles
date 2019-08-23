#!/usr/bin/env sh

# This needs 1 or 2 args
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    cat >&2 << EOF
Uploads a compressed copy of the specified path to the specified remote, using
zip and rclone.

Usage: $0 LOCAL_PATH RCLONE_REMOTE

Args:
    LOCAL_PATH: The local path to be synced.
    RCLONE_REMOTE: The rclone remote to by synced to.
    REMOTE_PATH: The path to directory to store file in the remote. Defaults to
    '/backup/\$(basename LOCAL_PATH)'.
EOF
    exit 1
fi

# Set up log file
echo "*** LOG \`$@\` ($(date)) ***"

# Parse Parameters (The above statement assures that these parameters exist)
LOCAL_PATH="$1"
# If REMOTE_PATH ($3) is empty, this is put at the root.
REMOTE_DEST="${2}:${3:-/backup/$(basename "$LOCAL_PATH")}"
ZIP_PATH="$(mktemp -d)/$(date +"%Y-%m-%d").zip"

# Compress the file (ignoring .git) for faster upload
zip -r "$ZIP_PATH" "$LOCAL_PATH" -x "*.git*"

# -vv (very verbose) flag is for debugging
# --tpslimit is so Drive doesn't generate 403 errors.
# --transfers describes how many files can be created in parrallel
# --drive-chunk-size determines how large the file in RAM can be before upload
# --links document but don't copy symlinks
rclone copy -vv --tpslimit 10 --transfers 16 --drive-chunk-size 128M --links \
    "$ZIP_PATH" "$REMOTE_DEST"
# NOTE: I have my own client ID set up for ncsu-drive
