#!/bin/sh

# Unity $(File) $(Line)
# Godot {file} {Line} {col}
FILE="$1"
LINE="$2"
COL="$3"

PIPE="$(pwd)/gamedev-nvim"

if [ -S "$PIPE" ]; then
    exec nvim --server "$PIPE" --remote-send "<C-\><C-n>:n${FILE}<CR>${LINE}gg${COL}|"
else
    exec neovide "$FILE" -- --listen "$PIPE"
fi
