#!/usr/bin/env bash

if [ ! -f /etc/pacman.d/mirrorlist.old ]; then
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
fi

if [ ! -f /etc/pacman.d/mirrorlist ] && [ -f /run/host/etc/pacman.d/mirrorlist ]; then
    cp /run/host/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist
fi
