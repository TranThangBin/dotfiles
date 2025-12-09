#!/usr/bin/env bash

if [ ! -f /etc/pacman.d/mirrorlist.old ]; then
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
fi

if [ ! -f /etc/pacman.d/mirrorlist ]; then
    ln -sf /run/host/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist
fi
