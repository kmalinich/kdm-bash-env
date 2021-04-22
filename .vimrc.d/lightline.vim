scriptencoding utf-8


" Base config
set laststatus=2
set noshowmode

" lightline config
let g:lightline = {
	\ 'colorscheme': 'powerlineish',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ]
	\ }
\ }


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
