#!/usr/bin/env bash

PASSKEY="$1"

if [ -n "$WAYLAND_DISPLAY" ]; then
    # probably insecure
    cliphist delete-query "$(gopass -o "$PASSKEY")"
fi
