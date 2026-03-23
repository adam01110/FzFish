function _fzfish_preview_fn -d "Preview the function definition"
    set -l candidate "$fzfish_candidate"

    if type -q bat
        type $candidate | bat --color=always --language fish $fzfish_bat_opts
        return
    end

    type $candidate
end
