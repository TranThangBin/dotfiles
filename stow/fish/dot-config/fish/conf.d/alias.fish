if command -v podman &>/dev/null
    alias docker podman
end

if command -v nvim &>/dev/null
    alias vim nvim
    alias vi /usr/bin/vim
end
