#!/bin/sh

_audio_fix() {
    yay -S --needed --noconfirm \
        "openal" \
        "pipewire" \
        "pipewire-alsa" \
        "pipewire-jack" \
        "pipewire-pulse" \
        "wireplumber"
}

_audio_fix
yay -S --needed --noconfirm \
    "dashbinsh" \
    "faugus-launcher" \
    "legacy-launcher" \
    "libcanberra" \
    "mangohud" \
    "osu-lazer-bin" \
    "proton-cachyos-slr" \
    "spacecadetpinball-bin" \
    "wine-mono"

if [ -n "$CONTAINER_ID" ]; then
    for app in \
        "faugus-launcher" \
        "legacy-launcher" \
        "osu-lazer" \
        "spacecadetpinball" \
        "steam"; do

        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done
fi
