#!/bin/sh

cd "$(dirname "$0")" || exit

PACKAGES_DIR="$(pwd)/../packages"

cd - >/dev/null || exit

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

if command -v yay >/dev/null 2>&1; then
    for package_file in "$PACKAGES_DIR/$CONTAINER_ID"/*; do
        if [ ! -f "$package_file" ]; then
            continue
        fi

        yay -S --needed --noconfirm - <"$package_file"
    done
fi
