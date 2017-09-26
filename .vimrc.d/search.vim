" Blink search highlight for 5 seconds
set matchtime=5

" Disable previous search highlight
" set nohlsearch

" Search as you type
set incsearch

" Case-insensitive search...
set ignorecase
" ... unless there's a capital letter
set smartcase

" Search mappings
" If off-screen, scroll the next find to the center of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Show matching brackets
set showmatch
