set dir "tests/_resources/dir with spaces"
set fzfish_candidate "$dir/file.bin"
set -gx fzfish_hexyl_opts --border none

function hexyl
    printf '%s\n' $argv
end

set actual (_fzfish_preview_file)
set rendered (string join -- ' ' $actual)

@test "binary preview uses hexyl" (string match -- "*--border*none*$dir/file.bin*" "$rendered") = "$rendered"

functions -e hexyl
set -e fzfish_hexyl_opts
