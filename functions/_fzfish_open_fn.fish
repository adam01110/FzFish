function _fzfish_open_fn -d "Open a function definition using open file wrapper"
    set -l details (functions --details $fzfish_candidate 2>/dev/null)
    set -l filepath "$details[1]"

    if test -f "$filepath"
        _fzfish_open_file "$filepath"
    end
end
