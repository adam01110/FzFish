set -gx _fifc_comp_count 0
set -gx _fifc_unordered_comp
set -gx _fifc_ordered_comp
set -gx _fifc_launched_by_fzf 1

source conf.d/fifc.fish

function _fifc_preview_process
    echo process-preview
end

set -gx _fifc_complist_path (mktemp)
printf 'fish\n' >$_fifc_complist_path

set -gx fifc_commandline 'pkill '
set -gx fifc_candidate fish
set -gx fifc_group
set -gx fifc_desc
set -gx _fifc_extract_regex

function pgrep
    echo 101
end

set actual (_fifc_action preview fish)
@test "pkill uses process preview rule" "$actual" = process-preview

functions -e _fifc_preview_process
functions -e pgrep
rm -f $_fifc_complist_path
set -e _fifc_comp_count
set -e _fifc_unordered_comp
set -e _fifc_ordered_comp
set -e _fifc_launched_by_fzf
set -e _fifc_complist_path
set -e fifc_commandline
set -e fifc_candidate
set -e fifc_group
set -e fifc_desc
set -e _fifc_extract_regex
