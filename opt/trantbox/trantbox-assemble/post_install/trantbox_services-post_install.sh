#!/usr/bin/env sh

yay -S --needed --noconfirm \
    "awww-git" \
    "brightnessctl" \
    "calf" \
    "cliphist" \
    "easyeffects" \
    "fcitx5" \
    "fcitx5-configtool" \
    "fcitx5-unikey" \
    "lsp-plugins" \
    "mpv" \
    "network-manager-applet" \
    "pipewire" \
    "swayidle" \
    "swaync" \
    "waybar" \
    "wireplumber" \
    "wl-clipboard" \
    "wlsunset"

if [ -n "$CONTAINER_ID" ]; then
    for app in \
        "easyeffects" \
        "fcitx5-configtool" \
        "mpv"; do

        distrobox-export --app "$app" --enter-flags "--no-workdir"
    done

    for bin in \
        "/usr/bin/awww" \
        "/usr/bin/cliphist" \
        "/usr/bin/wl-copy" \
        "/usr/bin/wl-paste"; do

        distrobox-export --bin "$bin" --enter-flags "--no-workdir"
    done

    for bin in \
        "uwsm-app" \
        "loginctl" \
        "systemctl" \
        "hyprctl" \
        "swaylock"; do

        sudo ln -sf "/usr/bin/distrobox-host-exec" "/usr/local/bin/$bin"
    done
fi
