#!/usr/bin/env bash

_gremlin_picker_install() {
    local packages=(
        "fontconfig"
        "libxkbcommon"
        "pipewire"
        "pipewire-pulse"
        "python"
        "qt6-multimedia"
        "qt6-wayland"
        "uv"
    )

    local PIN="8170d348cd6516c3e56ccf9130e5e128bcdc35eb"
    local URL="https://raw.githubusercontent.com/iluvgirlswithglasses/linux-desktop-gremlin/$PIN/install.sh"
    local SHA256SUM="ab8c554602317014c723110b14812576477f722e885d8192fff60076886d655e"

    local install_script checksum
    install_script="$(curl -fsSL "$URL")"
    checksum="$(sha256sum <<<"$install_script" | awk '{print $1}')"

    if [ "$SHA256SUM" = "$checksum" ]; then
        yay -S --needed --noconfirm "${packages[@]}"
        bash <<<"$install_script"
    fi
}

packages=(
    "catimg"
    "fastfetch"
    "fd"
    "git"
    "gopass"
    "ripgrep"
    "rofimoji"
    "trash-cli"
    "unrar"
    "unzip"
    "vim"
    "yt-dlg"
    "yt-dlp"
    "zip"
)

yay -S --needed --noconfirm "${packages[@]}"
_gremlin_picker_install

if [ -n "$CONTAINER_ID" ]; then
    exported_binaries=(
        "/usr/bin/catimg"
        "/usr/bin/fastfetch"
        "/usr/bin/fd"
        "/usr/bin/gopass"
        "/usr/bin/rg"
        "/usr/bin/rofimoji"
        "/usr/bin/trash"
        "/usr/bin/trash-empty"
        "/usr/bin/trash-list"
        "/usr/bin/trash-restore"
        "/usr/bin/trash-rm"
        "/usr/bin/unrar"
        "/usr/bin/unzip"
        "/usr/bin/zip"
    )
    exported_apps=(
        "gremlin-picker"
        "yt-dlg"
    )
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
