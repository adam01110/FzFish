function _fzfish_preview_dir -d "List content of the selected directory"
    set -l filepath "$fzfish_candidate"

    if set --query fzf_preview_dir_cmd
        eval "$fzf_preview_dir_cmd '$filepath'"
        return
    end

    for dir_cmd in eza exa
        if type -q $dir_cmd
            $dir_cmd -1a --color=always $fzfish_exa_opts "$filepath"
            return
        end
    end

    ls -A -F $fzfish_ls_opts "$filepath"
end
