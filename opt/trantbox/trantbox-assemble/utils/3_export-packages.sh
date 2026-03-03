#!/bin/sh

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

cd "$(dirname "$0")" || exit

EXPORT_DIR="$(pwd)/../export/$CONTAINER_ID"

cd - >/dev/null || exit

APPS_FILE="$EXPORT_DIR/apps"
BINS_FILE="$EXPORT_DIR/bins"
IMPORTS_FILE="$EXPORT_DIR/imports"

if [ -f "$APPS_FILE" ]; then
    while IFS= read -r app; do
        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done <"$APPS_FILE"
fi

if [ -f "$BINS_FILE" ]; then
    while IFS= read -r bin; do
        distrobox-export --bin "$bin" --enter-flags "--no-workdir"
    done <"$BINS_FILE"
fi

if [ -f "$IMPORTS_FILE" ]; then
    while IFS= read -r import; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$import"
    done <"$IMPORTS_FILE"
fi
