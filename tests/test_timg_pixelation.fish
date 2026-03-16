set -gx fifc_timg_pixelation sixel
@test "timg pixelation honors explicit sixel override" (_fifc_timg_pixelation) = -ps
set -e fifc_timg_pixelation

set -gx fifc_timg_pixelation kitty
@test "timg pixelation honors explicit kitty override" (_fifc_timg_pixelation) = -pk
set -e fifc_timg_pixelation

set -gx KITTY_WINDOW_ID 1
@test "timg pixelation detects kitty protocol support" (_fifc_timg_pixelation) = -pk
set -e KITTY_WINDOW_ID
