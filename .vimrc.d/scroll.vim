" Make scrolling and highlighters fast
set lazyredraw
if !has('nvim')
	set ttyfast
endif

" Keep at least 2 lines above/below
set scrolloff=2

" Keep at least 2 lines left/right
set sidescrolloff=2
