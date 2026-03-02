#!/bin/sh

_gremlin_picker_install() {
    PIN="8170d348cd6516c3e56ccf9130e5e128bcdc35eb"
    URL="https://raw.githubusercontent.com/iluvgirlswithglasses/linux-desktop-gremlin/$PIN/install.sh"
    SHA256SUM="ab8c554602317014c723110b14812576477f722e885d8192fff60076886d655e"

    install_script="$(curl -fsSL "$URL")"
    checksum="$(printf "%s\n" "$install_script" | sha256sum | awk '{print $1}')"

    if [ "$SHA256SUM" = "$checksum" ]; then
        yay -S --needed --noconfirm \
            "fontconfig" \
            "libxkbcommon" \
            "pipewire" \
            "pipewire-pulse" \
            "python" \
            "qt6-multimedia" \
            "qt6-wayland" \
            "uv"

        printf "%s" "$install_script" | bash
    fi
}

yay -S --needed --noconfirm \
    "catimg" \
    "dashbinsh" \
    "fastfetch" \
    "fd" \
    "git" \
    "gopass" \
    "ripgrep" \
    "rofimoji" \
    "trash-cli" \
    "unrar" \
    "unzip" \
    "vim" \
    "yt-dlg" \
    "yt-dlp" \
    "zip"

_gremlin_picker_install

if [ -n "$CONTAINER_ID" ]; then
    for bin in \
        "/usr/bin/catimg" \
        "/usr/bin/fastfetch" \
        "/usr/bin/fd" \
        "/usr/bin/gopass" \
        "/usr/bin/rg" \
        "/usr/bin/rofimoji" \
        "/usr/bin/trash" \
        "/usr/bin/trash-empty" \
        "/usr/bin/trash-list" \
        "/usr/bin/trash-restore" \
        "/usr/bin/trash-rm" \
        "/usr/bin/unrar" \
        "/usr/bin/unzip" \
        "/usr/bin/zip"; do

        distrobox-export --bin "$bin" --enter-flags "--no-workdir"
    done

    for app in \
        "gremlin-picker" \
        "yt-dlg"; do

        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done

    sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/rofi"
fi
