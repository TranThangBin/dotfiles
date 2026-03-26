#!/bin/sh

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

cd "$(dirname "$0")" || exit

POST_INSTALL_DIR="$(pwd)/../post_install/$CONTAINER_ID"

cd - >/dev/null || exit

if [ ! -d "$POST_INSTALL_DIR" ]; then
    exit
fi

for script in "$POST_INSTALL_DIR"/*; do
    "$script"
done
