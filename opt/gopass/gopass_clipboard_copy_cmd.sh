#!/bin/sh

if [ -n "$WAYLAND_DISPLAY" ]; then
    wl-copy --sensitive
fi
