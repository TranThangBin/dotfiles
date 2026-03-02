#!/bin/sh

# Original source from https://github.com/iluvgirlswithglasses/linux-desktop-gremlin/blob/b475b0f3044074f61208c35b9ebd764954e2c836/install.sh
# This version has been through some modification

#!/bin/bash
# Run this script with INCLUDES_GIT=1 in order to install the entire git history

# ========================================================================================
# Clone the repo into ~/.config
# ========================================================================================

set --
if [ -z "${INCLUDES_GIT}" ]; then
    set -- --depth 1
fi
# FLAG=""
# if [[ -z "${INCLUDES_GIT}" ]]; then
#     FLAG="--depth 1"
# fi

echo "Cloning repo into ~/.config/linux-desktop-gremlin..."

git clone "$@" https://github.com/iluvgirlswithglasses/linux-desktop-gremlin ~/.config/linux-desktop-gremlin
# git clone $FLAG https://github.com/iluvgirlswithglasses/linux-desktop-gremlin ~/.config/linux-desktop-gremlin

cd ~/.config/linux-desktop-gremlin || exit
# cd ~/.config/linux-desktop-gremlin

# ========================================================================================
# Install uv and sync
# ========================================================================================

export PATH="$PATH:$HOME/.local/bin"
# export PATH=$PATH:$HOME/.local/bin

if command -v uv >/dev/null 2>&1; then
    echo "Found uv package manager..."
else
    echo "uv is not installed, installing..."
    echo "Executing: curl -LsSf https://astral.sh/uv/install.sh | sh"
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

uv sync

# ========================================================================================
# Create desktop files and symlinks
# ========================================================================================

exec ./scripts/make-desktop-files.sh
# bash ./scripts/make-desktop-files.sh
