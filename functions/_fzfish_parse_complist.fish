function _fzfish_parse_complist -d "Extract the first column of fish completion list"
    string unescape <$_fzfish_complist_path \
        | uniq \
        | awk -F '\t' '{ print $1 }'
end
