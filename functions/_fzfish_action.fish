function _fzfish_action
    # Can be either "preview", "open" or "source"
    set -l action $argv[1]
    set -l comp $_fzfish_ordered_comp $_fzfish_unordered_comp
    set -l regex_val (string escape --style=regex -- "$argv[2]")
    # Escape '/' for sed processing
    set regex_val (string replace '/' '\/' --all "$regex_val")

    # Variables exposed to evaluated commands
    set -x fzfish_desc (sed -nr (printf 's/^%s[[:blank:]]+(.*)/\\\1/p' "$regex_val") $_fzfish_complist_path | string trim)
    set -x fzfish_candidate "$argv[2]"
    set -x fzfish_extracted (string match --regex --groups-only -- "$_fzfish_extract_regex" "$argv[2]")

    set -l default_preview 0
    set -l default_source 0

    switch "$action"
        case preview
            set default_preview 1
            set fzfish_query "$argv[3]"
        case open
            set fzfish_query "$argv[3]"
        case source
            set default_source 1
    end

    for comp_name in $comp
        set -l comp_entry $$comp_name
        set -l condition_cmd $comp_entry[1]
        set -l regex_spec $comp_entry[2]
        set -l preview_cmd $comp_entry[3]
        set -l open_cmd $comp_entry[4]
        set -l source_cmd $comp_entry[5]
        set -l source_fzf_opts $comp_entry[6]
        set -l extract_regex $comp_entry[7]
        set -l regex_cmd

        if test -z "$condition_cmd"
            set condition_cmd true
        end

        if test -n "$regex_spec"
            set -l val (string escape -- "$fzfish_commandline")
            set regex_cmd "string match --regex --quiet -- '$regex_spec' $val"
        else
            set regex_cmd true
        end

        if not eval "$condition_cmd; and $regex_cmd"
            continue
        end

        set _fzfish_extract_regex "$extract_regex"

        switch "$action"
            case preview
                if test -n "$preview_cmd"
                    eval $preview_cmd
                    set default_preview 0
                    break
                end
            case open
                if test -n "$open_cmd"
                    eval $open_cmd
                    break
                end
            case source
                if test -n "$source_cmd"
                    set -g _fzfish_default_source_fzf_opts $source_fzf_opts
                    if functions "$source_cmd" 1>/dev/null
                        eval $source_cmd
                    else
                        echo $source_cmd
                    end
                    set default_source 0
                    break
                end
        end
    end

    switch "$action"
        case preview
            # We are in preview mode, but nothing matched
            # fallback to fish description
            if test "$default_preview" = 1
                echo "$fzfish_desc"
            end
        case source
            if test "$default_source" = 1
                if set -q fzfish_wrap_default_preview; and test "$fzfish_wrap_default_preview" = true
                    set -g _fzfish_default_source_fzf_opts '--preview-window "wrap"'
                end
                echo _fzfish_parse_complist
            end
    end
end
