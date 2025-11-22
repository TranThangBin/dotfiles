if command -v podman &>/dev/null
    set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"
end
