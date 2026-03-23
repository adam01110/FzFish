functions -c _fzfish_source_files _fzfish_source_files_original

function _fzfish_source_files
    printf '%s\n' $argv
end

set actual (_fzfish_source_directories | string join '|')
@test "directory source delegates depth and type" "$actual" = "1|d"

set -gx fzfish_fd_opts --hidden
set actual (_fzfish_source_directories | string join '|')
@test "directory source ignores transport details" "$actual" = "1|d"

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = fd
        return 1
    end

    builtin type $argv
end

set -e fzfish_fd_opts
set -e fzfish_find_opts
set actual (_fzfish_source_directories | string join '|')
@test "directory source uses same delegation without fd" "$actual" = "1|d"

set -gx fzfish_find_opts -maxdepth 2
set actual (_fzfish_source_directories | string join '|')
@test "directory source stays independent from find opts" "$actual" = "1|d"

functions -e type
functions -e _fzfish_source_files
functions -c _fzfish_source_files_original _fzfish_source_files
functions -e _fzfish_source_files_original

set -e fzfish_fd_opts
set -e fzfish_find_opts
