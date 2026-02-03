#!/usr/bin/env bash

if [ -n "$WAYLAND_DISPLAY" ]; then
    wl-copy --sensitive
fi
