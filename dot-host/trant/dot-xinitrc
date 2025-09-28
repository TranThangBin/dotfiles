#!/usr/bin/env bash

wm=i3

export PATH=$PATH:$HOME/.local/bin

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS:$XDG_CONFIG_HOME:/etc/xdg"

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$XDG_DATA_HOME:/usr/local/share:/usr/share"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export XDG_SESSION_DESKTOP="$wm"
export XDG_CURRENT_DESKTOP="$wm"
export XDG_SESSION_TYPE=x11
export XDG_BACKEND=x11
export XDG_SESSION_CLASS=user

export QT_QPA_PLATFORMTHEME=qt6ct

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

export TERMINAL=ghostty

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment &>/dev/null; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

exec "$wm"
