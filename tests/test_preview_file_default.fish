function set_color
end

function file
    if test "$argv[1]" = --mime-type
        echo text/plain
    else if test "$argv[1]" = -b
        echo ASCII text
    end
end

set actual (_fzfish_preview_file_default "tests/_resources/dir with spaces/file 1.txt")

@test "default preview prints mime" "$actual[1]" = text/plain
@test "default preview keeps blank separator" "$actual[2]" = ''
@test "default preview prints description" "$actual[3]" = 'ASCII text'

functions -e set_color
functions -e file
