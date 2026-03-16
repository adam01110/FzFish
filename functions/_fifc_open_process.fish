function _fifc_open_process -d "Open the tree view of the selected process (procs only)"
    set -l pids (_fifc_parse_pid "$fifc_candidate")

    if test -z "$pids"
        if string match --regex --quiet -- '(^|.*\h)pkill(\h|$)' "$fifc_commandline"
            set pids (pgrep -- "$fifc_candidate" 2>/dev/null)
        end
    end

    if type -q procs
        procs --color=always --tree --pager=always $fifc_procs_opts $pids
    end
end
