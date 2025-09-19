#!/usr/bin/env bash

"$(dirname "$(realpath "$0")")/paru-install.sh"

packages=(
    "webcord-bin" "teams" "brave-bin" "pwvucontrol" "bottles"
    "godot-beta-bin" "unityhub"
    "hyprsysteminfo-git" "hyprqt6engine-git"
    "tor-browser-bin"
)

for package in "${packages[@]}"; do
    if ! pacman -Q "$package" &>/dev/null; then
        sudo -u "$USER" -- paru -S "$package"
    fi
done
