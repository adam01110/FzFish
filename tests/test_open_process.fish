function type
    if test "$argv[1]" = -q; and test "$argv[2]" = procs
        return 0
    end

    builtin type $argv
end

function pgrep
    echo 101
    echo 202
end

function procs
    echo "procs:$argv"
end

set fifc_commandline "pkill "
set fifc_candidate fish

set actual (_fifc_open_process)
@test "open process resolves pkill names with procs" "$actual" = "procs:--color=always --tree --pager=always 101 202"

functions -e type
functions -e pgrep
functions -e procs
set -e fifc_commandline
set -e fifc_candidate
