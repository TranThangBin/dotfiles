#!/usr/bin/bash

packages=(
    "mpv"
    "feh"
    "picom"
    "swaync"
    "fcitx5"
    "cliphist"
    "wlsunset"
    "awww-git"
    "wl-clipboard"
    "fcitx5-unikey"
    "fcitx5-configtool"
)

yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "mpv"
        "fcitx5-configtool"
    )
    exported_binaries=(
        "/usr/bin/feh"
        "/usr/bin/awww"
        "/usr/bin/picom"
        "/usr/bin/fcitx5"
        "/usr/bin/wl-copy"
        "/usr/bin/wl-paste"
        "/usr/bin/cliphist"
        "/usr/bin/swaync-client"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${exported_binaries[@]}"; do
        distrobox-export --bin "$bin"
    done
fi
