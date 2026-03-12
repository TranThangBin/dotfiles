#!/bin/sh

set -eu

HOST_MIRROR_LIST_FILE="/run/host/etc/pacman.d/mirrorlist"
BOX_MIRROR_LIST_FILE="/etc/pacman.d/mirrorlist"

if [ ! -f "$HOST_MIRROR_LIST_FILE" ]; then
    exit
fi

if [ ! -f "$BOX_MIRROR_LIST_FILE.old" ]; then
    mv "$BOX_MIRROR_LIST_FILE" "$BOX_MIRROR_LIST_FILE.old"
fi

if ! cmp -s "$HOST_MIRROR_LIST_FILE" "$BOX_MIRROR_LIST_FILE"; then
    cp "$HOST_MIRROR_LIST_FILE" "$BOX_MIRROR_LIST_FILE"
fi
