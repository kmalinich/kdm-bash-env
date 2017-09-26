" Shortcut key maps

" pbcopy for macOS copy/paste
if has('macunix')
	vmap <C-x> :!pbcopy<CR>
	vmap <C-c> :w !pbcopy<CR><CR>

	" Make it so copy/paste to system works from vim
	set clipboard=unnamed
endif

" Oops-Caps-Lock abbreviations
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Qall qall
cnoreabbrev Qall! qall!
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev WQ wq
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" jj to escape in insert mode
inoremap jj <Esc>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Remap semicolon to colon in normal mode (pinky thanks you)
nore ; :
" nore , ;

" Ctrl-B to delete to the end of line in insert mode
inoremap <C-b> <Esc>lDa
" Ctrl-E to reindent files
map <C-e> :call TrimReindent()<CR>
" Ctrl-H Enable/disable code concealing
map <C-h> :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
" Ctrl-J and Ctrl-K to navigate ale errors
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
" Ctrl-T to toggle NERDTree
map <C-t> :NERDTreeToggle<CR>
" Ctrl-W to strip trailing whitespace
map <C-w> :call RemoveTrailingChars()<CR>

" Bind F8 to fixing problems with ale
nmap <F8> <Plug>(ale_fix)

" Map \ml to append modeline
nnoremap ml :call ModelineAppend()<CR>

" Map \as to increase linting delay
nnoremap as :call ALELintSlow()<CR>
" Map \af to decrease linting delay
nnoremap af :call ALELintFast()<CR>

" Disable replace mode, which turns on in bad terminals for some reason
nnoremap R <Nop>
" Disable Ex mode
noremap Q <Nop>

" Tab navigation like Firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" This is for working across multiple xterms and/or gvims
" Transfer/read and write one block of text between vim sessions (capture whole line):
" Append
" nmap ;a :. w! >>~/.vimxfer<CR>
" Read
" nmap ;r :r ~/.vimxfer<CR>
" Write
" nmap ;w :. w! ~/.vimxfer<CR>
