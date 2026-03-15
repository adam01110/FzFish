set -gx fifc_token tests/_resources
set actual (_fifc_source_files)
@test "source files incomplete path falls back to fish completions" "$actual" = _fifc_parse_complist

set -gx fifc_token tests/_resources/
set -gx fifc_query tests/_resources/
set actual (_fifc_source_files)
string match --quiet -- "fd . *--max-depth 1*" "$actual"
@test "source files fd command limits depth" $status = 0
string match --quiet -- "*--no-ignore*" "$actual"
@test "source files fd command includes no-ignore" $status = 0
@test "source files directory path clears query" "$fifc_query" = ""

set -gx fifc_show_hidden true
set actual (_fifc_source_files)
string match --quiet -- "*--hidden*" "$actual"
@test "source files fd command shows hidden when enabled" $status = 0
set -e fifc_show_hidden

set -gx fifc_token "$PWD/"
set -gx fifc_query "$PWD/"
set actual (_fifc_source_files)
string match --quiet -- "* -- *" "$actual"
@test "source files pwd directory omits explicit path argument" $status = 1

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
string match --quiet -- "*! -path '*/.*'*" "$actual"
@test "source files find fallback excludes hidden by default" $status = 0
@test "source files find fallback clears query" "$fifc_query" = ""

set -gx fifc_show_hidden true
set actual (_fifc_source_files)
string match --quiet -- "*! -path '*/.*'*" "$actual"
@test "source files find fallback includes hidden when enabled" $status = 1
string match --quiet -- "*! -path .* -print*" "$actual"
@test "source files find fallback still prints matches" $status = 0

functions -e type
set -e fifc_token
set -e fifc_query
set -e fifc_show_hidden
set -e fifc_find_opts
