#!/usr/bin/env bash

"$(dirname "$(realpath "$0")")/paru-install.sh"

packages=("hyprcap")

for package in "${packages[@]}"; do
    if ! pacman -Q "$package" &>/dev/null; then
        sudo -u "$USER" -- paru -S "$package"
    fi
done
