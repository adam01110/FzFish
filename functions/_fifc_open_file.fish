function _fifc_open_file -d "Open a file with the right tool depending on its type"
    set -l filepath "$fifc_candidate"

    if test -n "$argv"
        set filepath "$argv"
    end

    set -q fifc_editor || set -l fifc_editor "$EDITOR"

    set -l file_type (_fifc_file_type "$filepath")

    switch $file_type
        case txt json archive
            $fifc_editor "$filepath"
        case image pdf
            if type -q timg
                set -l pixelation (_fifc_timg_pixelation)

                timg $pixelation --frames=1 --loops=1 --clear -E $fifc_timg_opts "$filepath" | less --RAW-CONTROL-CHARS
            else
                $fifc_editor "$filepath"
            end
        case binary
            if type -q hexyl
                hexyl $fifc_hexyl_opts "$filepath" | less --RAW-CONTROL-CHARS
            else
                $fifc_editor "$filepath"
            end
    end
end
