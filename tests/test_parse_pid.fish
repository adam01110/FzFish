function pgrep
    echo 101
    echo 202
end

set actual (_fzfish_parse_pid '  123 fish' 'pkill fish')
@test "parse pid extracts leading pid" "$actual" = 123

set actual (_fzfish_parse_pid fish 'pkill fish' | string split ' ')
@test "parse pid resolves pkill names" "$actual[1]" = 101
@test "parse pid resolves all pkill matches" "$actual[2]" = 202

functions -e pgrep
