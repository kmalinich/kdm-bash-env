scriptencoding utf-8

" airline/powerline base config
set laststatus=2
set noshowmode
let g:airline_theme = 'airlineish'


" airline/powerline symbol config
let g:airline_powerline_fonts = 1
let g:airline_left_sep        = ''
let g:airline_right_sep       = ''
let g:airline_right_alt_sep   = ''

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.branch     = ''
let g:airline_symbols.linenr     = ''
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.readonly   = ''
let g:airline_symbols.whitespace = 'Ξ'


" airline/powerline extension config
let g:airline#extensions#ale#enabled        = 1
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tagbar#enabled     = 1
let g:airline#extensions#virtualenv#enabled = 1
" Straight tabs
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep     = ' '


" airline/powerline extension symbol config
let g:airline#extensions#branch#prefix     = ''
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline#extensions#readonly#symbol   = '⊘'
