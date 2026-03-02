#!/bin/sh

cd "$(dirname "$0")" || exit

POST_INSTALL_DIR="$(pwd)/../post_install"

cd - >/dev/null || exit

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

for script in "$POST_INSTALL_DIR/$CONTAINER_ID"/*; do
    "$script"
done
