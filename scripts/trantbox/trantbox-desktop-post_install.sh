#!/usr/bin/env bash

packages=(
    "fd"
    "go"
    "git"
    "gcc"
    "npm"
    "rust"
    "make"
    "gimp"
    "btop"
    "godot"
    "which"
    "gopass"
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
    "thunderbird"
    "qt5-wayland"
    "wl-clipboard"
    "drawio-desktop"
    "tree-sitter-cli"
    "libreoffice-fresh"
)
aur_packages=(
    "teams"
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

exported_apps=(
    "obs"
    "gimp"
    "btop"
    "brave"
    "teams"
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

imported_binaries=("podman")

sudo pacman -S --needed --noconfirm "${packages[@]}"
paru -S --needed --noconfirm "${aur_packages}"
paru -S --needed --noconfirm neovide --assume-installed neovim
mkdir -p "$HOME/.local/share/unity3d"
for app in "${exported_apps[@]}"; do
    distrobox-export --app "$app"
done
for bin in "${imported_binaries[@]}"; do
    sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
done
