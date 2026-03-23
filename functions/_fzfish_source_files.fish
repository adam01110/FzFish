function _fzfish_source_files -d "Return a command to recursively find files"
    set -l depth $argv[1]
    set -q depth[1]; or set depth 1
    set -l type_flag $argv[2]
    set -l clear_query $argv[3]
    set -q clear_query[1]; or set clear_query true

    set -l raw_path (_fzfish_path_to_complete)
    set -l escaped_path (string escape -- $raw_path)
    set -l path_type (string match -rq '/$' -- "$raw_path"; and echo directory; or echo string)
    set -l hidden_path
    if string match -rq -- '(^|/)\.[^/]*/*$' "$raw_path"
        set hidden_path 1
    end

    # Clear query when token is a directory path - the source command already
    # scopes to this path, so the prefix would break --exact substring matching.
    if test "$clear_query" = true
        if string match --quiet -- '~*' "$fzfish_query"; or string match --quiet -- '*/' "$fzfish_query"
            set -e fzfish_query
        end
    end

    if test "$path_type" != directory
        echo _fzfish_parse_complist
        return
    end

    if type -q fd
        if _fzfish_test_version (fd --version) -ge "8.3.0"
            set fd_custom_opts --strip-cwd-prefix
        end

        set -l type_opt
        if test -n "$type_flag"
            set type_opt -t $type_flag
        end

        set -l hidden_flag
        if set -q fzfish_show_hidden; and test "$fzfish_show_hidden" = true
            set hidden_flag --hidden
        else if test -n "$hidden_path"
            set hidden_flag --hidden
        end

        set -l fd_base_opts $fzfish_fd_opts $type_opt --max-depth $depth --color=always --no-ignore $hidden_flag $fd_custom_opts

        if test "$raw_path" = "$PWD/"; or test "$raw_path" = "."
            echo "fd . $fd_base_opts"
        else
            echo "fd . $fd_base_opts -- $escaped_path"
        end
    else
        set -l find_type_opt
        if test "$type_flag" = d
            set find_type_opt -type d
        end

        if test -n "$hidden_path"
            echo "find . $escaped_path -maxdepth $depth $fzfish_find_opts $find_type_opt ! -path . -print 2>/dev/null | sed 's|^\./||'"
        else if set -q fzfish_show_hidden; and test "$fzfish_show_hidden" = true
            echo "find . $escaped_path -maxdepth $depth $fzfish_find_opts $find_type_opt ! -path . -print 2>/dev/null | sed 's|^\./||'"
        else
            echo "find . $escaped_path -maxdepth $depth $fzfish_find_opts $find_type_opt ! -path . ! -path '*/.*' -print 2>/dev/null | sed 's|^\./||'"
        end
    end
end
