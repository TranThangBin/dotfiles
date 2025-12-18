#!/usr/bin/env bash

packages=(
    "fd"
    "git"
    "zip"
    "unzip"
    "unrar"
    "gopass"
    "catimg"
    "ripgrep"
    "rofimoji"
    "fastfetch"
    "trash-cli"
)

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
    "/usr/bin/trash-rm"
    "/usr/bin/trash-put"
    "/usr/bin/trash-list"
    "/usr/bin/trash-empty"
    "/usr/bin/trash-restore"
)

imported_binaries=("rofi")

sudo pacman -S --needed --noconfirm "${packages[@]}"
for bin in "${exported_binaries[@]}"; do
    distrobox-export --bin "$bin"
done
for bin in "${imported_binaries[@]}"; do
    sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
done
