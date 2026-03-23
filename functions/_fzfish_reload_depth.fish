function _fzfish_reload_depth -d "Reload file/directory listing at specific depth"
    set -l depth $argv[1]
    set -l type_flag $argv[2]

    eval (_fzfish_source_files $depth $type_flag false)
end
