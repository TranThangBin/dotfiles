#!/usr/bin/bash

packages=(
    "mpv"
    "feh"
    "swww"
    "picom"
    "swaync"
    "fcitx5"
    "cliphist"
    "wlsunset"
    "wl-clipboard"
    "fcitx5-unikey"
    "fcitx5-configtool"
)

exported_apps=(
    "mpv"
    "fcitx5-configtool"
)

exported_binaries=(
    "/usr/bin/feh"
    "/usr/bin/swww"
    "/usr/bin/picom"
    "/usr/bin/fcitx5"
    "/usr/bin/wl-copy"
    "/usr/bin/wl-paste"
    "/usr/bin/cliphist"
    "/usr/bin/swaync-client"
)

sudo pacman -S --needed --noconfirm "${packages[@]}"
for app in "${exported_apps[@]}"; do
    distrobox-export --app "$app"
done
for bin in "${exported_binaries[@]}"; do
    distrobox-export --bin "$bin"
done
