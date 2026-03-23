function _fzfish_open_opt -d "Open a man page starting at the selected option"
    set -l cmd (string match --regex --groups-only -- '(^|\h+)(\w+) ?-*$' "$fzfish_commandline")
    set -l opt (string trim --chars '\n ' -- "$fzfish_candidate")
    set -l regex "^[[:blank:]]*(-+.*)*$opt"

    set -l output (man $cmd | col -b | string collect)

    set -l linenr (echo $output | awk "/$regex/{print NR}")
    set -l less_args "+$linenr"

    if type -q bat
        echo $output | bat --color=always --language man --style plain $fzfish_bat_opts \
            # --RAW-CONTROL-CHARS allow color output of bat to be displayed
            | less --RAW-CONTROL-CHARS $less_args
        return
    end

    man $cmd | less $less_args
end
