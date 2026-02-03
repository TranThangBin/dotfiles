#!/usr/bin/env bash

packages=(
    "fd"
    "git"
    "zip"
    "vim"
    "unzip"
    "unrar"
    "yt-dlp"
    "yt-dlg"
    "gopass"
    "catimg"
    "ripgrep"
    "rofimoji"
    "fastfetch"
    "trash-cli"
)

yay -S --needed --noconfirm "${packages[@]}"

if [ -n "$CONTAINER_ID" ]; then
    exported_binaries=(
        "/usr/bin/rg"
        "/usr/bin/fd"
        "/usr/bin/zip"
        "/usr/bin/unzip"
        "/usr/bin/unrar"
        "/usr/bin/gopass"
        "/usr/bin/catimg"
        "/usr/bin/rofimoji"
        "/usr/bin/fastfetch"
        "/usr/bin/trash"
        "/usr/bin/trash-rm"
        "/usr/bin/trash-list"
        "/usr/bin/trash-empty"
        "/usr/bin/trash-restore"
    )
    exported_apps=("yt-dlg")
    imported_binaries=("rofi")

    for bin in "${exported_binaries[@]}"; do
        distrobox-export --bin "$bin"
    done
    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${imported_binaries[@]}"; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
