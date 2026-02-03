#!/usr/bin/bash

packages=(
    "uv"
    "python"
    "pipewire"
    "fontconfig"
    "qt6-wayland"
    "libxkbcommon"
    "qt6-multimedia"
    "pipewire-pulse"
)

yay -S --needed --noconfirm "${packages[@]}"
curl -s https://raw.githubusercontent.com/iluvgirlswithglasses/linux-desktop-gremlin/refs/heads/main/install.sh | bash

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=("gremlin-picker")

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
fi
