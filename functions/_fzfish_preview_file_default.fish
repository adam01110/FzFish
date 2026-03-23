function _fzfish_preview_file_default -d "Display informations about the selected file"
    set -l filepath "$argv[1]"
    set -l mime (file --mime-type -b "$filepath")

    set_color brgreen
    printf '%s\n\n' "$mime[1]"
    set_color --bold white
    file -b "$filepath"
    set_color normal
end
