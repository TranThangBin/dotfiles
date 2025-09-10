#!/usr/bin/env sh

export PATH=$PATH:$HOME/.local/bin
export XDG_CONFIG_DIRS=$XDG_CONFIG_HOME:$XDG_CONFIG_DIRS
export QT_QPA_PLATFORMTHEME=qt6ct

exec i3
