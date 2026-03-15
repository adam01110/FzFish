functions -c _fifc_source_files _fifc_source_files_original

function _fifc_source_files
    printf '%s\n' "$fifc_fd_opts"
    printf '%s\n' --
    printf '%s\n' "$fifc_find_opts"
end

set -e fifc_fd_opts
set -e fifc_find_opts
set actual (_fifc_source_directories | string join '|')
@test "directory source adds fd type filter" "$actual" = "-t d|--|"

set -gx fifc_fd_opts --hidden
set actual (_fifc_source_directories | string join '|')
@test "directory source preserves existing fd opts" "$actual" = "--hidden -t d|--|"

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = fd
        return 1
    end

    builtin type $argv
end

set -e fifc_fd_opts
set -e fifc_find_opts
set actual (_fifc_source_directories | string join '|')
@test "directory source adds find type filter" "$actual" = "|--|-type d"

set -gx fifc_find_opts -maxdepth 2
set actual (_fifc_source_directories | string join '|')
@test "directory source preserves existing find opts" "$actual" = "|--|-maxdepth 2 -type d"

functions -e type
functions -e _fifc_source_files
functions -c _fifc_source_files_original _fifc_source_files
functions -e _fifc_source_files_original

set -e fifc_fd_opts
set -e fifc_find_opts
