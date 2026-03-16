set -g _mock_buffer 'kill '
set -g _mock_current_token ''
set -g _mock_group processes
set -g _mock_tmpfile "$PWD/tests/_tmp_main_command_process_extract"
set -g _mock_complist_path "$_mock_tmpfile"_fifc
set -g _mock_fzf_output_path "$_mock_tmpfile"_fifc_out
set -g _mock_source_output_path "$_mock_tmpfile"_fifc_source

function mktemp
    echo $_mock_tmpfile
end

function complete
    printf '%s\n' '249247\t/proc/self/exe --type=utility'
end

function commandline
    switch "$argv[1]"
        case --current-token
            echo $_mock_current_token
        case --cut-at-cursor -b
            echo $_mock_buffer
        case --replace
            set -g _mock_replaced $argv[-1]
        case --function
            set -g _mock_commandline_function $argv[2]
    end
end

function _fifc_completion_group
    echo $_mock_group
end

function _fifc_action
    if test "$argv[1]" = source
        set -g _fifc_extract_regex '^\\h*([0-9]+)'
        echo "printf '%s\\n' '249247 /proc/self/exe --type=utility'"
    end
end

function fzf
    set -g _mock_fzf_args $argv
    cat >/dev/null
    printf '%s\n' '249247 /proc/self/exe --type=utility'
end

set -gx fifc_open_keybinding ctrl-o
set -gx fifc_rm_cmd false

rm -f $_mock_complist_path $_mock_fzf_output_path $_mock_source_output_path
set -e _mock_replaced
set -e _mock_commandline_function

_fifc

@test "main command extracts pid from process selection" "$_mock_replaced" = '249247 '
@test "main command repaints after process extraction" "$_mock_commandline_function" = repaint

functions -e mktemp
functions -e complete
functions -e commandline
functions -e _fifc_completion_group
functions -e _fifc_action
functions -e fzf

set -e _mock_buffer
set -e _mock_current_token
set -e _mock_group
set -e _mock_tmpfile
set -e _mock_complist_path
set -e _mock_fzf_output_path
set -e _mock_source_output_path
set -e _mock_fzf_args
set -e _mock_replaced
set -e _mock_commandline_function
set -e fifc_open_keybinding
set -e fifc_rm_cmd

rm -f "$PWD/tests/_tmp_main_command_process_extract_fifc"
rm -f "$PWD/tests/_tmp_main_command_process_extract_fifc_out"
rm -f "$PWD/tests/_tmp_main_command_process_extract_fifc_source"
rm -f "$PWD/tests/_tmp_main_command_process_extract_fifc_source_cmd"
