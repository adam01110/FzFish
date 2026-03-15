set -q _fifc_comp_1
or _fifc_set_bindings

@test "bindings register directory source rule" "$_fifc_comp_1[1]" = 'test "$fifc_group" = "directories"'
@test "bindings register file source rule" "$_fifc_comp_2[1]" = 'test "$fifc_group" = "files"'
@test "bindings register process source rule" "$_fifc_comp_3[1]" = 'test "$fifc_group" = processes'

@test "bindings directory source command" "$_fifc_comp_1[5]" = _fifc_source_directories
set actual_dir_opts "$_fifc_comp_1[6]"
string match --quiet -- "*ctrl-j:transform(_fifc_depth_transform +1 d)*" "$actual_dir_opts"
@test "bindings directory opts include ctrl-j depth" $status = 0
string match --quiet -- "*alt-9:transform(_fifc_depth_transform 9 d)*" "$actual_dir_opts"
@test "bindings directory opts include numeric depth" $status = 0

@test "bindings file source command" "$_fifc_comp_2[5]" = _fifc_source_files
set actual_file_opts "$_fifc_comp_2[6]"
string match --quiet -- "*ctrl-j:transform(_fifc_depth_transform +1)*" "$actual_file_opts"
@test "bindings file opts include ctrl-j depth" $status = 0
string match --quiet -- "*alt-9:transform(_fifc_depth_transform 9)*" "$actual_file_opts"
@test "bindings file opts include numeric depth" $status = 0

@test "bindings process source command" "$_fifc_comp_3[5]" = 'ps -ax -o pid=,command='
