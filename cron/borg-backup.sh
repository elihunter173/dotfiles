#!/bin/sh

# Set up envars

usage() {
    cat << EOF
This script was ripped from https://borgbackup.readthedocs.io/en/stable/quickstart.html
and then modified to fit my needs.

To work automatically, this must be run by a user who can access $BORG_REPO
without user interaction. This means, if it is a remote server, that they must
have the SSH properly configured for their machines.

Usage: $0 [LOG_FILE]

Authors: Eli W. Hunter, Borg Team
EOF
}

# Some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# info, list, stats: show verbose output.
# filter: only show added, modified, or errored files.
# compression: lz for fast compression.
# exclude-caches: so we can exclude directories with a CACHEDIR.TAG file if we
# ever want to.
# archive name: our hostname and then a description of it.
borg create                            \
    --info                             \
    --filter AME                       \
    --list                             \
    --stats                            \
    --show-rc                          \
    --compression lz4                  \
    --exclude-caches                   \
    \
    ::'{hostname}-src-{now:%Y-%m-%d}' \
    $SRC \
    $NOTES \

backup_exit=$?

info "Pruning repository"

# `prune` deletes old archives to reach the requested 'keep' amount.
# prefix is used to assure that we don't mess with any other machine's backups.
borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# Use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
