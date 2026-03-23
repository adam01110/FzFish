set _fzfish_complist_path (mktemp)
printf '%s\n' \
    'plain\tDescription' \
    'plain\tDescription' \
    'dir\ with\ spaces/\tDirectory' >$_fzfish_complist_path

set actual (_fzfish_parse_complist)
@test "parse complist extracts first column" "$actual[1]" = plain
@test "parse complist unescapes completion values" "$actual[2]" = 'dir with spaces/'
@test "parse complist deduplicates identical rows" (count $actual) = 2

command $fzfish_rm_cmd $_fzfish_complist_path
set -e _fzfish_complist_path
