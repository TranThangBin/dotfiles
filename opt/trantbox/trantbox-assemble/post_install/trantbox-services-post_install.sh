#!/usr/bin/bash

packages=(
    "awww-git"
    "brightnessctl"
    "cliphist"
    "easyeffects"
    "fcitx5"
    "fcitx5-configtool"
    "fcitx5-unikey"
    "lsp-plugins"
    "mpv"
    "network-manager-applet"
    "pipewire"
    "quickshell"
    "swayidle"
    "swaync"
    "waybar"
    "wireplumber"
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
        "/usr/bin/wl-copy"
        "/usr/bin/wl-paste"
    )
    imported_binaries=(
        "uwsm-app"
        "loginctl"
        "systemctl"
        "hyprctl"
        "swaylock"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done
    for bin in "${exported_binaries[@]}"; do
        distrobox-export --bin "$bin" --enter-flags "--no-workdir"
    done
    for bin in "${imported_binaries[@]}"; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
