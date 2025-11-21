#!/usr/bin/env bash

packages=(
    "legacy-launcher"
    "openal"
    "mangohud"
    "wireplumber"
    "pipewire"
    "pipewire-jack"
    "pipewire-alsa"
    "pipewire-pulse"
)

exported_apps=(
    "steam"
    "legacy-launcher"
)

paru -S --needed --noconfirm "${packages[@]}"
paru -S --needed --noconfirm steam umu-launcher --overwrite "*"
for app in "${exported_apps[@]}"; do
    distrobox-export --app "$app"
done
