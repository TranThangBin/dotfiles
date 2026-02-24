#!/usr/bin/env bash

_audio_fix() {
    local packages=(
        "openal"
        "pipewire"
        "pipewire-alsa"
        "pipewire-jack"
        "pipewire-pulse"
        "wireplumber"
    )

    yay -S --needed --noconfirm "${packages[@]}"
}

packages=(
    "faugus-launcher"
    "legacy-launcher"
    "libcanberra"
    "mangohud"
    "osu-lazer-bin"
    "spacecadetpinball-bin"
    "wine-mono"
)

_audio_fix
yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "faugus-launcher"
        "legacy-launcher"
        "osu-lazer"
        "spacecadetpinball"
        "steam"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done
fi
