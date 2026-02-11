#!/usr/bin/env bash

packages=(
    "faugus-launcher"
    "legacy-launcher"
    "mangohud"
    "openal"
    "osu-lazer-bin"
    "pipewire"
    "pipewire-alsa"
    "pipewire-jack"
    "pipewire-pulse"
    "wine-mono"
    "wireplumber"
)

yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "faugus-launcher"
        "legacy-launcher"
        "osu-lazer"
        "steam"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
fi
