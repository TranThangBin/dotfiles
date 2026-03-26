#!/bin/sh

set -eu

# Unity $(File) $(Line)
# Godot {file} {Line} {col}
file=""
line=0
col=0
frontend="nvim"
terminal="ghostty"

cwd="$(pwd)"
socket_path="$cwd/gamedev-nvim"
use_term=0

while [ "$#" -gt 0 ]; do
    opt="$1"
    shift

    case "$opt" in
    --file)
        file="$1"
        shift
        ;;
    --line)
        line="$1"
        shift
        ;;
    --column)
        col="$1"
        shift
        ;;
    --frontend)
        frontend="$1"
        shift
        ;;
    --terminal)
        terminal="$1"
        shift
        ;;
    esac
done

if [ -S "$socket_path" ]; then
    exec nvim --server "$socket_path" --remote-send "<C-\><C-n>:n${file}<CR>${line}gg${col}|"
fi

case "$frontend" in
nvim)
    set -- nvim "$file" --listen "$socket_path"
    use_term=1
    ;;
neovide)
    set -- neovide "$file" -- --listen "$socket_path"
    ;;
*)
    exit 1
    ;;
esac

if [ "$use_term" -eq 0 ]; then
    exec "$@"
fi

if [ -n "${CONTAINER_ID:-}" ] && ! command -v "$terminal" >/dev/null 2>&1; then
    exec distrobox-host-exec -- "$terminal" -e distrobox-enter "$CONTAINER_ID" -- sh -c "cd $cwd && exec $*"
fi

exec "$terminal" -e "$@"
