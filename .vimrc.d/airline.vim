scriptencoding utf-8


" Base config
set laststatus=2
set noshowmode

" Theme
"# let g:airline_theme = 'airlineish'

" Symbols
" let g:airline_left_sep        = ''
" let g:airline_right_sep       = ''
" let g:airline_right_alt_sep   = ''

" let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" let g:airline_symbols.branch     = ''
let g:airline_symbols.linenr     = ''
" let g:airline_symbols.paste      = 'ρ'
" let g:airline_symbols.readonly   = ''
" let g:airline_symbols.whitespace = 'Ξ'


" Extensions
" let g:airline_extensions = []
" let g:airline#extensions#branch#enabled     = 1
" let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tagbar#enabled     = 0
" let g:airline#extensions#virtualenv#enabled = 0

" Straight tabs
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#left_sep     = ' '

" Extension symbols
let g:airline#extensions#branch#prefix     = ''
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline#extensions#readonly#symbol   = '⊘'


" ALE section configuration
" let g:airline#extensions#ale#enabled        = 0
" let g:airline#extensions#ale#error_symbol   = '✗ '
" let g:airline#extensions#ale#warning_symbol = '⚠  '


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
