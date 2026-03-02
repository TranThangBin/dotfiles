#!/bin/sh

cd "$(dirname "$0")" || exit

EXPORT_DIR="$(pwd)/../export"

cd - >/dev/null || exit

if [ -z "$CONTAINER_ID" ]; then
    printf "%s\n" "You must run $0 inside a container!" 1>&2
    exit 1
fi

APPS_DIR="$EXPORT_DIR/$CONTAINER_ID/apps"
BINS_DIR="$EXPORT_DIR/$CONTAINER_ID/bins"
IMPORTS_DIR="$EXPORT_DIR/$CONTAINER_ID/imports"

if [ -f "$APPS_DIR" ]; then
    while IFS= read -r app; do
        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done <"$APPS_DIR"
fi

if [ -f "$BINS_DIR" ]; then
    while IFS= read -r bin; do
        distrobox-export --bin "$bin" --enter-flags "--no-workdir"
    done <"$BINS_DIR"
fi

if [ -f "$IMPORTS_DIR" ]; then
    while IFS= read -r import; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$import"
    done <"$IMPORTS_DIR"
fi
