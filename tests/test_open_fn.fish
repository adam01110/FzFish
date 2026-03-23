function functions
    if test "$argv[1]" = --details; and test "$argv[2]" = my_fn
        printf '%s\n' 'tests/_resources/dir with spaces/file 1.txt' autoloaded 12
        return 0
    end

    builtin functions $argv
end

function _fzfish_open_file
    echo "OPEN:$argv"
end

set fzfish_candidate my_fn

set actual (_fzfish_open_fn)
@test "function open uses file path from details" "$actual" = 'OPEN:tests/_resources/dir with spaces/file 1.txt'

builtin functions -e functions
builtin functions -e _fzfish_open_file
