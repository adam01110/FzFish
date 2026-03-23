function man
    printf '%s\n' NAME '  --help show help' '  more help' '  --version show version'
end

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = rg
        return 0
    end

    if test "$argv[1]" = -q
        return 1
    end

    builtin type $argv
end

function rg
    printf '%s\n' '--help show help' 'more help' '--version show version'
end

function awk
    printf '%s\n' '--help show help' 'more help'
end

function set_color
end

set fzfish_commandline 'mkdir -'
set fzfish_candidate --help

set actual (_fzfish_preview_opt)
@test "preview option prints selected synopsis" "$actual[1]" = '--help show help'
@test "preview option keeps blank separator" "$actual[2]" = ''
@test "preview option prints body" "$actual[3]" = 'more help'

functions -e man
functions -e type
functions -e rg
functions -e awk
functions -e set_color
