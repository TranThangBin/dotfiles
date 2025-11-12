if ! status is-login && ! path is -f /tmp/fastfetch-ran && ! set -q ZELLIJ
    function fish_greeting
        if command -v fastfetch &>/dev/null
            touch /tmp/fastfetch-ran
            fastfetch
        end
    end
end
