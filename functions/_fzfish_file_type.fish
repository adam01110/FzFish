function _fzfish_file_type -d "Figure out file type (txt, json, image, pdf, archive, binary)"
    set -l filepath "$argv[1]"
    set -l mime (file --mime-type -b "$filepath")
    set -l text_type txt

    switch $mime
        case application/{gzip,java-archive,x-{7z-compressed,bzip2,chrome-extension,rar,tar,xar},zip}
            echo archive
            return
        case "image/*"
            echo image
            return
        case application/pdf
            set text_type pdf
        case application/json
            set text_type json
    end

    if string match --quiet '*binary*' -- (file --mime -b -L "$filepath")
        echo binary
    else
        echo $text_type
    end
end
