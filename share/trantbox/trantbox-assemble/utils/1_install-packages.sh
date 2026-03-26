#!/bin/sh

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

cd "$(dirname "$0")" || exit

PACKAGES_DIR="$(pwd)/../packages/$CONTAINER_ID"

cd - >/dev/null || exit

if command -v yay >/dev/null 2>&1; then
    if [ ! -d "$PACKAGES_DIR" ]; then
        exit
    fi

    for package_file in "$PACKAGES_DIR"/*; do
        if [ ! -f "$package_file" ]; then
            continue
        fi

        yay -S --needed --noconfirm - <"$package_file"
    done
fi
