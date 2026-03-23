function man
    printf '%s\n' NAME '  --help show help'
end

function col
    cat
end

function awk
    echo 2
end

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = bat
        return 0
    end

    builtin type $argv
end

function bat
    echo "BAT:$argv"
    cat
end

function less
    echo "$argv"
    cat
end

set fzfish_commandline 'mkdir -'
set fzfish_candidate --help
set fzfish_bat_opts '--paging=never'

set actual (_fzfish_open_opt)
@test "open option bat path keeps less raw control chars" "$actual[1]" = '--RAW-CONTROL-CHARS +2'
@test "open option bat path keeps bat opts" "$actual[2]" = 'BAT:--color=always --language man --style plain --paging=never'

functions -e man
functions -e col
functions -e awk
functions -e type
functions -e bat
functions -e less
set -e fzfish_bat_opts
