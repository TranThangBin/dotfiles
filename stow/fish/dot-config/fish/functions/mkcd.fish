function mkcd
    set -l literal 0
    set -l last_dir ""

    for arg in $argv
        if test "$literal" -ne 1; and test "$arg" = --
            set literal 1
        else if test "$literal" -eq 1; or test (string sub -l 1 -- "$arg") != -
            set last_dir "$arg"
        end
    end

    mkdir $argv; or return "$status"

    if test -n "$last_dir"
        cd -- "$last_dir"
    end
end
