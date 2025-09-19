#!/usr/bin/env bash

if ! pacman -Q paru-bin &>/dev/null; then
    sudo -u $USER -- makepkg --noconfirm --needed -si -D $DISTROBOX_HOST_HOME/paru-bin
fi
