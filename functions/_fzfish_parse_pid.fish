function _fzfish_parse_pid -d "Extract pids from process candidates"
    set -l candidate $argv[1]
    set -l commandline $argv[2]
    set -l pids (string match --regex --groups-only -- "^\h*([0-9]+)" "$candidate")

    if test -n "$pids"
        echo $pids
        return
    end

    if test -n "$commandline"
        if string match --regex --quiet -- '(^|.*\h)pkill(\h|$)' "$commandline"
            set pids (pgrep -- "$candidate" 2>/dev/null)
        end
    end

    echo $pids
end
