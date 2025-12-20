#!/usr/bin/env bash

packages=(
    "yay-bin"
    "openal"
    "mangohud"
    "wine-mono"
    "wireplumber"
    "pipewire"
    "pipewire-jack"
    "pipewire-alsa"
    "pipewire-pulse"
)
aur_packages=(
    "legacy-launcher"
)

exported_apps=(
    "steam"
    "legacy-launcher"
)

sudo pacman -S --needed --noconfirm "${packages[@]}"
yay -S --needed --noconfirm "${aur_packages[@]}"
for app in "${exported_apps[@]}"; do
    distrobox-export --app "$app"
done
