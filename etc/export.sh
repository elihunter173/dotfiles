#/usr/bin/env sh

# Check if the current user is root
if [[ $(id --user) -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# The following two variables are used to allows this script to be run from anywhere.
# The path to this script (resolving symbolic links).
script_path=$(readlink -f $0)
# The path to the parent of this script.
parent_dir=${script_path%/*}

echo "Exporting udev rules..."
cp ${parent_dir}/udev/rules.d/* /etc/udev/rules.d/. \
    && echo "SUCCESS" || echo "FAILURE"
