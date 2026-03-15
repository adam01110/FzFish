set -gx fifc_token tests/_resources
set actual (_fifc_source_files)
@test "source files incomplete path falls back to fish completions" "$actual" = _fifc_parse_complist

set -gx fifc_token tests/_resources/
set -gx fifc_query tests/_resources/
set actual (_fifc_source_files)
set match (string match -- "fd . *--max-depth 1*" "$actual")
@test "source files fd command limits depth" "$match" = "$actual"
set match (string match -- "*--no-ignore*" "$actual")
@test "source files fd command includes no-ignore" "$match" = "$actual"
@test "source files directory path clears query" "$fifc_query" = ""

set -gx fifc_show_hidden true
set actual (_fifc_source_files)
set match (string match -- "*--hidden*" "$actual")
@test "source files fd command shows hidden when enabled" "$match" = "$actual"
set -e fifc_show_hidden

set -gx fifc_token "$PWD/"
set -gx fifc_query "$PWD/"
set actual (_fifc_source_files)
set match (string match -- "* -- *" "$actual")
@test "source files pwd directory omits explicit path argument" "$match" = ""

function type
    if test "$argv[1]" = -q; and test "$argv[2]" = fd
        return 1
    end

    builtin type $argv
end

set -gx fifc_token tests/_resources/
set -gx fifc_query tests/_resources/
set -e fifc_find_opts
set actual (_fifc_source_files)
set match (string match -- "*! -path '*/.*'*" "$actual")
@test "source files find fallback excludes hidden by default" "$match" = "$actual"
@test "source files find fallback clears query" "$fifc_query" = ""

set -gx fifc_show_hidden true
set actual (_fifc_source_files)
set match (string match -- "*! -path '*/.*'*" "$actual")
@test "source files find fallback includes hidden when enabled" "$match" = ""
set match (string match -- "*! -path .* -print*" "$actual")
@test "source files find fallback still prints matches" "$match" = "$actual"

functions -e type
set -e fifc_token
set -e fifc_query
set -e fifc_show_hidden
set -e fifc_find_opts
