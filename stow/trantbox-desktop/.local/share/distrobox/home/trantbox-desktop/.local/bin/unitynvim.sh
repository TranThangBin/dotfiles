#!/usr/bin/env bash

# $(File) $(Line)
FILE="$1"
LINE="$2"

PIPE="$PWD/unitynvim"

if [[ -S "$PIPE" ]]; then
    exec nvim --server "$PIPE" --remote-send "<C-\><C-n>:n${FILE}<CR>${LINE}gg^"
else
    exec neovide "$FILE" -- --listen "$PIPE"
fi

