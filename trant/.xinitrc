#!/usr/bin/env bash

export PATH=$PATH:$HOME/.local/bin
export XDG_CONFIG_DIRS=$XDG_CONFIG_HOME:$XDG_CONFIG_DIRS
export QT_QPA_PLATFORMTHEME=qt6ct

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment &>/dev/null; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

exec i3
