#!/usr/bin/env sh

if [ -n "$CONTAINER_ID" ]; then
    exec distrobox-host-exec "$0" "$@"
fi

cd "$(dirname "$0")" || exit

FILE_DIR="$(pwd)"
DOTFILES_DIR="$(realpath "./dotfiles")"
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
    container_name="trantbox-desktop"

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
volume="$DOTFILES_DIR/stow/WebCord/dot-config/WebCord/Themes:$DISTROBOX_HOME_ROOT/$container_name/.config/WebCord/Themes:ro"
volume="$DOTFILES_DIR/stow/btop/dot-config/btop/btop.conf:$DISTROBOX_HOME_ROOT/$container_name/.config/btop/btop.conf:ro"
volume="$DOTFILES_DIR/stow/neovide/dot-config/neovide:$DISTROBOX_HOME_ROOT/$container_name/.config/neovide:ro"
volume="$DOTFILES_DIR/stow/zellij/dot-config/zellij:$DISTROBOX_HOME_ROOT/$container_name/.config/zellij:ro"
volume="$DOTFILES_DIR/stow/neovim/dot-config/nvim:$DISTROBOX_HOME_ROOT/$container_name/.config/nvim:ro"
volume="$DOTFILES_DIR/stow/neovim/dot-config/nvim/nvim-pack-lock.json:$DISTROBOX_HOME_ROOT/$container_name/.config/nvim/nvim-pack-lock.json:rw"
volume="$DOTFILES_DIR/stow/git/dot-config/git:$DISTROBOX_HOME_ROOT/$container_name/.config/git:ro"
volume="$DOTFILES_DIR/stow/opencode/dot-config/opencode/opencode.json:$DISTROBOX_HOME_ROOT/$container_name/.config/opencode/opencode.json:ro"
volume="$HOME/.ssh:$DISTROBOX_HOME_ROOT/$container_name/.ssh:ro"
EOF

    if ! _have_extra; then
        return 0
    fi

    cat <<EOF
volume="/extra/$USER/Unity:$DISTROBOX_HOME_ROOT/trantbox-desktop/Unity:rw"
EOF
}

_trantbox_games() {
    container_name="trantbox-games"

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
volume="$DOTFILES_DIR/stow/MangoHud/dot-config/MangoHud:$DISTROBOX_HOME_ROOT/$container_name/.config/MangoHud:ro"
EOF

    if ! _have_extra; then
        return 0
    fi

    cat <<EOF
volume="/extra/$USER/.local/share/Steam:$DISTROBOX_HOME_ROOT/trantbox-games/.local/share/Steam:rw"
volume="/extra/$USER/Games:$DISTROBOX_HOME_ROOT/trantbox-games/Games:rw"
volume="/extra/$USER/Faugus:$DISTROBOX_HOME_ROOT/trantbox-games/Faugus:rw"
EOF
}

_trantbox_services() {
    container_name="trantbox-services"

    cat <<EOF
$(_trantbox_head "$container_name")
unshare_all=true
volume="$DOTFILES_DIR/stow/fcitx5/dot-local/share/fcitx5:$DISTROBOX_HOME_ROOT/$container_name/.local/share/fcitx5:ro"
volume="$DOTFILES_DIR/stow/fcitx5/dot-config/fcitx5:$DISTROBOX_HOME_ROOT/$container_name/.config/fcitx5:ro"
volume="$DOTFILES_DIR/stow/swaync/dot-config/swaync:$DISTROBOX_HOME_ROOT/$container_name/.config/swaync:ro"
volume="$DOTFILES_DIR/stow/swayidle/dot-config/swayidle:$DISTROBOX_HOME_ROOT/$container_name/.config/swayidle:ro"
volume="$DOTFILES_DIR/stow/waybar/dot-config/waybar:$DISTROBOX_HOME_ROOT/$container_name/.config/waybar:ro"
volume="$DOTFILES_DIR/stow/quickshell/dot-config/quickshell:$DISTROBOX_HOME_ROOT/$container_name/.config/quickshell:ro"
volume="$DOTFILES_DIR/stow/easyeffects/dot-local/share/easyeffects/output:$DISTROBOX_HOME_ROOT/$container_name/.local/share/easyeffects/output:ro"
volume="$DOTFILES_DIR/stow/easyeffects/dot-local/share/easyeffects/irs:$DISTROBOX_HOME_ROOT/$container_name/.local/share/easyeffects/irs:ro"
EOF
}

_trantbox_utils() {
    container_name="trantbox-utils"

    cat <<EOF
$(_trantbox_head "$container_name")
unshare_all=true
volume="$DOTFILES_DIR/stow/rofimoji/dot-config/rofimoji.rc:$DISTROBOX_HOME_ROOT/$container_name/.config/rofimoji.rc:ro"
volume="$DOTFILES_DIR/stow/fastfetch/dot-config/fastfetch:$DISTROBOX_HOME_ROOT/$container_name/.config/fastfetch:ro"
volume="$DOTFILES_DIR/stow/git/dot-config/git:$DISTROBOX_HOME_ROOT/$container_name/.config/git:ro"
volume="$HOME/.ssh:$DISTROBOX_HOME_ROOT/$container_name/.ssh:ro"
EOF
}

_trantbox_desktop
_trantbox_games
_trantbox_services
_trantbox_utils
