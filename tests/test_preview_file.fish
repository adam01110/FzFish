set dir "tests/_resources/dir with spaces"
set fzfish_candidate "$dir/file 1.txt"
set fzfish_bat_opts '--color=never'

set actual (_fzfish_preview_file)
@test "builtin file preview" "$actual" = 'foo 1'

function bat
    printf '%s\n' $argv
end

set fzfish_candidate "$dir/file.json"
set actual_json (_fzfish_preview_file | string join ' ')
@test "json preview uses bat json syntax" (string match -- "*--style=plain*--color=always*-l*json*--color=never*$dir/file.json*" "$actual_json") = "$actual_json"

functions -e bat
