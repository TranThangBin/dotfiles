#!/usr/bin/env bash

packages=(
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
    "osu-lazer-bin"
)

yay -S --needed --noconfirm "${packages[@]}" "${aur_packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "steam"
        "legacy-launcher"
        "osu-lazer"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
fi
