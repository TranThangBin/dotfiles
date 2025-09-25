#!/usr/bin/env bash

# {file} {Line} {col}
FILE="$1"
LINE="$2"
COL="$3"

PIPE="$PWD/godotnvim"

if [[ -S "$PIPE" ]]; then
    nvim --server "$PIPE" --remote-send "<C-\><C-n>:n${FILE}<CR>${LINE}gg${COL}|"
else
    neovide "$FILE" -- --listen "$PIPE"
fi
