function man
    printf '%s\n' NAME "  --help show help" "  --version show version"
end

function col
    cat
end

function awk
    echo 2
end

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = bat
        return 1
    end

    builtin type $argv
end

function less
    echo "$argv"
end

set fifc_commandline "mkdir -"
set fifc_candidate --help

set actual (_fifc_open_opt)
@test "open option jumps to computed line" "$actual" = "+2"

functions -e man
functions -e col
functions -e awk
functions -e type
functions -e less
