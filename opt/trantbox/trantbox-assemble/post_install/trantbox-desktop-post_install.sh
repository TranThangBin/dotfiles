#!/usr/bin/env sh

yay -S --needed --noconfirm \
    "bear" \
    "blender" \
    "brave-bin" \
    "btop" \
    "discord" \
    "dotnet-sdk" \
    "drawio-desktop" \
    "fd" \
    "firefox" \
    "gcc" \
    "gimp" \
    "git" \
    "go" \
    "godot" \
    "lazydocker" \
    "libfdk-aac" \
    "libnotify" \
    "libreoffice-fresh" \
    "libresprite" \
    "luarocks" \
    "make" \
    "neovim-nightly-bin" \
    "nodejs" \
    "npm" \
    "obs-studio" \
    "opencode" \
    "postman-bin" \
    "pwvucontrol" \
    "python3" \
    "qt5-wayland" \
    "rider" \
    "ripgrep" \
    "rust" \
    "sfxr-qt-bin" \
    "shotcut" \
    "teams-for-linux" \
    "thunderbird" \
    "tor-browser-bin" \
    "tree-sitter-cli" \
    "unityhub" \
    "unixodbc" \
    "webcord-bin" \
    "which" \
    "wl-clipboard" \
    "zellij"

yay -S --needed --noconfirm neovide --assume-installed neovim
mkdir -p "$HOME/.local/share/unity3d"

if [ -n "$CONTAINER_ID" ]; then
    for app in \
        "blender" \
        "brave" \
        "btop" \
        "discord" \
        "drawio" \
        "firefox" \
        "gimp" \
        "godot" \
        "libreoffice" \
        "libresprite" \
        "neovide" \
        "obs" \
        "pwvucontrol" \
        "rider" \
        "sfxr-qt" \
        "shotcut" \
        "teams-for-linux" \
        "thunderbird" \
        "tor-browser" \
        "unityhub" \
        "webcord"; do

        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done

    sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/podman"
fi
