scriptencoding utf-8


" Make scrolling and highlighters fast
set lazyredraw
if !has('nvim')
	set ttyfast
endif

set ttimeoutlen=40

" Keep at least 3 lines above/below
set scrolloff=3

" Keep at least 3 lines left/right
set sidescrolloff=3

" Scroll 2 lines when cursor leaves screen
" set scrolljump=2


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
