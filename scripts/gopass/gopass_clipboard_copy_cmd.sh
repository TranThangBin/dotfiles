#!/usr/bin/env bash

if [ -n "$WAYLAND_DISPLAY" ]; then
    # password is pass through stdin
    wl-copy
fi
