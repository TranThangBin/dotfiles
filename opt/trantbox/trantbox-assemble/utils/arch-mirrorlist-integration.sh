#!/bin/sh

if [ -f /run/host/etc/pacman.d/mirrorlist ] &&
    [ -f /etc/pacman.d/mirrorlist ] &&
    [ ! -f /etc/pacman.d/mirrorlist.old ]; then

    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
    ln -sf /run/host/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist
fi
