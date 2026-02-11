#!/usr/bin/bash

packages=(
    "awww-git"
    "cliphist"
    "fcitx5"
    "fcitx5-configtool"
    "fcitx5-unikey"
    "feh"
    "mpv"
    "picom"
    "swaync"
    "wl-clipboard"
    "wlsunset"
)

yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "fcitx5-configtool"
        "mpv"
    )
    exported_binaries=(
        "/usr/bin/awww"
        "/usr/bin/cliphist"
        "/usr/bin/fcitx5"
        "/usr/bin/feh"
        "/usr/bin/picom"
        "/usr/bin/swaync-client"
        "/usr/bin/wl-copy"
        "/usr/bin/wl-paste"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${exported_binaries[@]}"; do
        distrobox-export --bin "$bin"
    done
fi
