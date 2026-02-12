#!/usr/bin/env bash

packages=(
    "bear"
    "brave-bin"
    "btop"
    "discord"
    "dotnet-sdk"
    "drawio-desktop"
    "fd"
    "firefox"
    "gcc"
    "gimp"
    "git"
    "go"
    "godot"
    "lazydocker"
    "libfdk-aac"
    "libnotify"
    "libreoffice-fresh"
    "luarocks"
    "make"
    "neovim-nightly-bin"
    "nodejs"
    "npm"
    "obs-studio"
    "opencode"
    "postman-bin"
    "pwvucontrol"
    "python3"
    "qt5-wayland"
    "rider"
    "ripgrep"
    "rust"
    "sfxr-qt-bin"
    "shotcut"
    "teams-for-linux"
    "thunderbird"
    "tor-browser-bin"
    "tree-sitter-cli"
    "unityhub"
    "webcord-bin"
    "which"
    "wl-clipboard"
    "zellij"
)

yay -S --needed --noconfirm "${packages[@]}"
yay -S --needed --noconfirm neovide --assume-installed neovim
mkdir -p "$HOME/.local/share/unity3d"

if [ -n "$CONTAINER_ID" ]; then
    exported_apps=(
        "brave"
        "btop"
        "discord"
        "drawio"
        "firefox"
        "gimp"
        "godot"
        "libreoffice"
        "neovide"
        "obs"
        "pwvucontrol"
        "rider"
        "sfxr-qt"
        "shotcut"
        "teams-for-linux"
        "thunderbird"
        "tor-browser"
        "unityhub"
        "webcord"
    )
    imported_binaries=("podman")

    for app in "${exported_apps[@]}"; do
        distrobox-export --app "$app"
    done
    for bin in "${imported_binaries[@]}"; do
        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
