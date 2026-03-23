function _fzfish_preview_cmd -d "Open man page of the selected command"
    set -l candidate "$fzfish_candidate"

    if type -q bat
        man $candidate 2>/dev/null | bat --color=always --language man $fzfish_bat_opts
        return
    end

    man $candidate 2>/dev/null
end
