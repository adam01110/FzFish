function _fifc_preview_file -d "Preview the selected file with the right tool depending on its type"
    set -l file_type (_fifc_file_type "$fifc_candidate")

    switch $file_type
        case txt
            if type -q bat
                bat --style=plain --color=always $fifc_bat_opts "$fifc_candidate"
            else
                cat "$fifc_candidate"
            end
        case json
            if type -q bat
                bat --style=plain --color=always -l json $fifc_bat_opts "$fifc_candidate"
            else
                cat "$fifc_candidate"
            end
        case image pdf
            if type -q timg
                set -l pixelation (_fifc_timg_pixelation)

                set -l preview_columns 80
                set -l preview_lines 40

                set -q FZF_PREVIEW_COLUMNS
                and set preview_columns $FZF_PREVIEW_COLUMNS

                set -q FZF_PREVIEW_LINES
                and set preview_lines $FZF_PREVIEW_LINES

                set -l preview_width (math "max(1, $preview_columns)")
                set -l preview_height (math "max(1, $preview_lines * 2)")
                timg $pixelation --frames=1 --loops=1 -E -g"$preview_width"x"$preview_height" $fifc_timg_opts "$fifc_candidate"
            else
                _fifc_preview_file_default "$fifc_candidate"
            end
        case archive
            if type -q 7z
                7z l ""$fifc_candidate"" | tail -n +17 | awk '{ print $6 }'
            else
                _fifc_preview_file_default "$fifc_candidate"
            end
        case binary
            if type -q hexyl
                hexyl $fifc_hexyl_opts "$fifc_candidate"
            else
                _fifc_preview_file_default "$fifc_candidate"
            end

    end
end
