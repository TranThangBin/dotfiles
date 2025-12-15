#!/usr/bin/env bash

if [ -n "$WAYLAND_DISPLAY" ]; then
    cliphist delete-query "$@"
fi
