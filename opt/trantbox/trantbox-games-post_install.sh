#!/usr/bin/env bash

packages=(
    "openal"
    "mangohud"
    "wine-mono"
    "wireplumber"
    "faugus-launcher"
    "osu-lazer-bin"
    "legacy-launcher"
    "pipewire"
    "pipewire-jack"
    "pipewire-alsa"
    "pipewire-pulse"
)

yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "steam"
        "faugus-launcher"
        "legacy-launcher"
        "osu-lazer"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
fi
