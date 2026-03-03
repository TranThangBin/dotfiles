#!/bin/sh

if [ -n "$CONTAINER_ID" ]; then
    exec distrobox-host-exec "$0" "$@"
fi

cd "$(dirname "$0")" || exit

FILE_DIR="$(pwd -P)"
DOTFILES_DIR="$(cd "../../../.." && pwd -P)"
DISTROBOX_HOME_ROOT="$HOME/distrobox"

cd - >/dev/null || exit

_have_extra() {
    [ -d "/extra/$USER" ] &&
        [ -r "/extra/$USER" ] &&
        [ -w "/extra/$USER" ]
}

_trantbox_head() {
    container_name="$1"

    cat <<EOF
[$container_name]
home="$DISTROBOX_HOME_ROOT/$container_name"
image="docker.io/cachyos/cachyos:latest"
start_now=true
entry=true
additional_packages="yay-bin"
pre_init_hooks="export SHELL=/usr/bin/fish"
pre_init_hooks="$FILE_DIR/arch-mirrorlist-integration.sh"
volume="$container_name-cache:/var/cache/pacman/pkg:rw"
volume="$DOTFILES_DIR/stow/fish/dot-config/fish:$DISTROBOX_HOME_ROOT/$container_name/.config/fish:ro"
EOF
}

_trantbox_desktop() {
    container_name="trantbox_desktop"
    distrobox_home="$DISTROBOX_HOME_ROOT/$container_name"

    cat <<EOF
$(_trantbox_head "$container_name")
nvidia=true
unshare_devsys=true
unshare_groups=true
unshare_ipc=true
unshare_netns=true
additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/var/run/dbus/system_bus_socket"
additional_flags="--network host"
volume="/dev/input:/dev/input:ro"
volume="$DOTFILES_DIR/stow/WebCord/dot-config/WebCord/Themes:$distrobox_home/.config/WebCord/Themes:ro"
volume="$DOTFILES_DIR/stow/btop/dot-config/btop/btop.conf:$distrobox_home/.config/btop/btop.conf:ro"
volume="$DOTFILES_DIR/stow/neovide/dot-config/neovide:$distrobox_home/.config/neovide:ro"
volume="$DOTFILES_DIR/stow/zellij/dot-config/zellij:$distrobox_home/.config/zellij:ro"
volume="$DOTFILES_DIR/stow/neovim/dot-config/nvim:$distrobox_home/.config/nvim:ro"
volume="$DOTFILES_DIR/stow/neovim/dot-config/nvim/nvim-pack-lock.json:$distrobox_home/.config/nvim/nvim-pack-lock.json:rw"
volume="$DOTFILES_DIR/stow/git/dot-config/git:$distrobox_home/.config/git:ro"
volume="$DOTFILES_DIR/stow/opencode/dot-config/opencode/opencode.json:$distrobox_home/.config/opencode/opencode.json:ro"
volume="$HOME/.ssh:$distrobox_home/.ssh:ro"
EOF

    if ! _have_extra; then
        return 0
    fi

    cat <<EOF
volume="/extra/$USER/Unity:$distrobox_home/Unity:rw"
EOF
}

_trantbox_games() {
    container_name="trantbox_games"
    distrobox_home="$DISTROBOX_HOME_ROOT/$container_name"

    cat <<EOF
$(_trantbox_head "$container_name")
nvidia=true
unshare_devsys=true
unshare_groups=true
unshare_netns=true
unshare_process=true
additional_flags="--env-file $DOTFILES_DIR/misc/distrobox/nvidia.env"
additional_flags="--env PROTON_ENABLE_WAYLAND=1"
additional_flags="--env PROTON_USE_WOW64=1"
additional_flags="--env MANGOHUD=1"
additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/var/run/dbus/system_bus_socket"
additional_flags="--network host"
additional_packages="steam"
volume="/dev/input:/dev/input:ro"
volume="$DOTFILES_DIR/stow/MangoHud/dot-config/MangoHud:$distrobox_home/.config/MangoHud:ro"
EOF

    if ! _have_extra; then
        return 0
    fi

    cat <<EOF
volume="/extra/$USER/.local/share/Steam:$distrobox_home/.local/share/Steam:rw"
volume="/extra/$USER/Games:$distrobox_home/Games:rw"
volume="/extra/$USER/Faugus:$distrobox_home/Faugus:rw"
EOF
}

_trantbox_services() {
    container_name="trantbox_services"
    distrobox_home="$DISTROBOX_HOME_ROOT/$container_name"

    cat <<EOF
$(_trantbox_head "$container_name")
unshare_all=true
volume="$DOTFILES_DIR/stow/fcitx5/dot-local/share/fcitx5:$distrobox_home/.local/share/fcitx5:ro"
volume="$DOTFILES_DIR/stow/fcitx5/dot-config/fcitx5:$distrobox_home/.config/fcitx5:ro"
volume="$DOTFILES_DIR/stow/swaync/dot-config/swaync:$distrobox_home/.config/swaync:ro"
volume="$DOTFILES_DIR/stow/swayidle/dot-config/swayidle:$distrobox_home/.config/swayidle:ro"
volume="$DOTFILES_DIR/stow/waybar/dot-config/waybar:$distrobox_home/.config/waybar:ro"
volume="$DOTFILES_DIR/stow/easyeffects/dot-local/share/easyeffects/output:$distrobox_home/.local/share/easyeffects/output:ro"
volume="$DOTFILES_DIR/stow/easyeffects/dot-local/share/easyeffects/irs:$distrobox_home/.local/share/easyeffects/irs:ro"
EOF
}

_trantbox_utils() {
    container_name="trantbox_utils"
    distrobox_home="$DISTROBOX_HOME_ROOT/$container_name"

    cat <<EOF
$(_trantbox_head "$container_name")
unshare_all=true
volume="$DOTFILES_DIR/stow/rofimoji/dot-config/rofimoji.rc:$distrobox_home/.config/rofimoji.rc:ro"
volume="$DOTFILES_DIR/stow/fastfetch/dot-config/fastfetch:$distrobox_home/.config/fastfetch:ro"
volume="$DOTFILES_DIR/stow/git/dot-config/git:$distrobox_home/.config/git:ro"
volume="$HOME/.ssh:$distrobox_home/.ssh:ro"
EOF
}

_trantbox_desktop
_trantbox_games
_trantbox_services
_trantbox_utils
