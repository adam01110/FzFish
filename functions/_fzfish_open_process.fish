function _fzfish_open_process -d "Open the tree view of the selected process (procs only)"
    set -l pids (_fzfish_parse_pid "$fzfish_candidate" "$fzfish_commandline")
    set -l procs_args --color=always --tree --pager=always $fzfish_procs_opts

    if type -q procs
        procs $procs_args $pids
    end
end
