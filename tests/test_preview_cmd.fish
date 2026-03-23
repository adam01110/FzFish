function man
    echo "MAN:$argv"
end

function bat
    echo "BAT:$argv"
    cat
end

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = bat
        return 0
    end

    builtin type $argv
end

set fzfish_candidate mkdir
set fzfish_bat_opts '--style=plain'

set actual (_fzfish_preview_cmd)
@test "command preview uses bat wrapper" "$actual[1]" = "BAT:--color=always --language man --style=plain"
@test "command preview preserves man output" "$actual[2]" = "MAN:mkdir"

functions -e man
functions -e bat
functions -e type
set -e fzfish_bat_opts
