set dir "tests/_resources/dir with spaces"
set fzfish_candidate "$dir/file.bin"
set -gx fzfish_hexyl_opts --border none

function hexyl
    printf '%s\n' $argv
end

function less
    cat
end

set actual (_fzfish_open_file)
set rendered (string join -- ' ' $actual)

@test "binary open uses hexyl" (string match -- "*--border*none*$dir/file.bin*" "$rendered") = "$rendered"

functions -e hexyl
functions -e less
set -e fzfish_hexyl_opts
