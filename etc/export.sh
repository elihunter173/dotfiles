#/usr/bin/env sh

# Check if the current user is root
if [ $(id --user) -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi
cd $(dirname $0)
cp -r . /etc/.
