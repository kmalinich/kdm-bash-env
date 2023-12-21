scriptencoding utf-8


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


" Disable replace mode, which turns on in bad terminals for some reason
nnoremap R <Nop>

" Disable Ex mode
noremap Q <Nop>


" jj : escape in insert mode
inoremap jj <Esc>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Remap semicolon to colon in normal mode
nnoremap ; :

" j : backward
" k : forward
" nnoremap j k
" nnoremap k j

" w : previous word (works well if e : next word)
nnoremap w b


" Training wheels
nnoremap q <Nop>
"nnoremap a <Nop>
nnoremap j <Nop>
nnoremap k <Nop>
nnoremap r <Nop>
nnoremap s <Nop>
nnoremap h <Nop>
nnoremap l <Nop>
"nnoremap c <Nop>
nnoremap v <Nop>
nnoremap b <Nop>


" Ctrl-d : delete current line
inoremap <C-d> <Esc>ddi
nnoremap <C-d> <Esc>dd

" Ctrl-h : Enable/disable code concealing
map <C-h> :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>


" Tab navigation, normal mode
nnoremap <C-[> :tabprevious<CR>
nnoremap <C-]> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
