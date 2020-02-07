" Shortcut key maps

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

" jj : escape in insert mode
inoremap jj <Esc>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Remap semicolon to colon in normal mode (pinky thanks you)
nnoremap ; :
" nore , ;

" Make j go backwards and k go forwards
nnoremap j k
nnoremap k j

" Ctrl-d : delete current line
inoremap <C-d> <Esc>ddi
nnoremap <C-d> <Esc>dd

" Ctrl-h : Enable/disable code concealing
map <C-h> :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" Map \ml to append modeline
nnoremap ml :call ModelineAppend()<CR>

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
