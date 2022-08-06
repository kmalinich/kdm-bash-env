scriptencoding utf-8



" Italic support (requires neovim and proper ~/.terminfo)
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Format comments in italic
highlight Comment cterm=italic gui=italic

" Show visible whitespace
set list

" Ctrl-L to enable/disable whitespace indicators
map <C-l> :set list!<CR>


" Neovim Python config
let g:python_host_prog  = 'python2'
let g:python3_host_prog = 'python3'

set pyxversion=3

" Fix for pastetoggle bug
set nopaste


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
