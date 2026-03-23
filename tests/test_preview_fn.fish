function bat
    echo "BAT:$argv"
    cat
end

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = bat
        return 0
    end

    if test "$argv[1]" = my_fn
        echo 'function my_fn'
        return 0
    end

    builtin type $argv
end

set fzfish_candidate my_fn
set fzfish_bat_opts '--style=plain'

set actual (_fzfish_preview_fn)
@test "function preview uses bat wrapper" "$actual[1]" = "BAT:--color=always --language fish --style=plain"
@test "function preview preserves type output" "$actual[2]" = "function my_fn"

functions -e bat
functions -e type
set -e fzfish_bat_opts
