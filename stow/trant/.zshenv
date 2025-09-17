if [[ -z "$CONTAINER_ID" ]]; then
    export ZDOTDIR="$HOME"
else
    export ZDOTDIR="$DISTROBOX_HOST_HOME"
fi
export EDITOR=nvim
