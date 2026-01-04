#!/usr/bin/env bash

packages=(
    "fd"
    "go"
    "git"
    "gcc"
    "npm"
    "bear"
    "rust"
    "make"
    "gimp"
    "btop"
    "godot"
    "which"
    "zellij"
    "nodejs"
    "python3"
    "ripgrep"
    "discord"
    "shotcut"
    "firefox"
    "luarocks"
    "libnotify"
    "lazydocker"
    "dotnet-sdk"
    "obs-studio"
    "libfdk-aac"
    "thunderbird"
    "qt5-wayland"
    "wl-clipboard"
    "drawio-desktop"
    "tree-sitter-cli"
    "libreoffice-fresh"
)
aur_packages=(
    "rider"
    "unityhub"
    "brave-bin"
    "webcord-bin"
    "pwvucontrol"
    "postman-bin"
    "sfxr-qt-bin"
    "tor-browser-bin"
    "neovim-nightly-bin"
)

imported_binaries=("podman")

yay -S --needed --noconfirm "${packages[@]}" "${aur_packages[@]}"
yay -S --needed --noconfirm neovide --assume-installed neovim
mkdir -p "$HOME/.local/share/unity3d"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "obs"
        "gimp"
        "btop"
        "brave"
        "godot"
        "rider"
        "discord"
        "shotcut"
        "firefox"
        "neovide"
        "unityhub"
        "thunderbird"
        "webcord"
        "pwvucontrol"
        "sfxr-qt"
        "drawio"
        "tor-browser"
        "libreoffice"
    )

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${imported_binaries[@]}"; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
