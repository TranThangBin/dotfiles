#!/usr/bin/bash

packages=(
    "uv"
    "python"
    "pipewire"
    "fontconfig"
    "qt6-wayland"
    "libxkbcommon"
    "pipewire-pulse"
)

yay -S --needed --noconfirm "${packages[@]}"
curl -s https://raw.githubusercontent.com/iluvgirlswithglasses/linux-desktop-gremlin/refs/heads/main/install.sh | bash

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=("gremlin-picker")
    imported_binaries=("rofi")

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${imported_binaries[@]}"; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
