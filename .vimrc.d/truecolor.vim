scriptencoding utf-8


" True (24-bit) color support (requires supporting terminal emulator)
let &t_8f = "\e[38;2;%lu;%lu;%lum"
let &t_8b = "\e[48;2;%lu;%lu;%lum"
set termguicolors

" F10 : Show highlight group for text under cursor
map <F10> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" Custom whitespace list characters
set listchars=tab:\|,trail:,nbsp:+


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
