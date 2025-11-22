#!/usr/bin/env bash
FILE_PATH="$(realpath "${BASH_SOURCE[0]}")"
FILE_DIR="$(dirname "$FILE_PATH")"

if [ ! "$FILE_DIR" = "$HOME/dotfiles_utils" ]; then
    realpath "$FILE_DIR/../../.."
fi
