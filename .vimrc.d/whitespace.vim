scriptencoding utf-8

" Remove trailing spaces
command! RemoveTrailingSpaces %s/\s\+$//e
" Remove trailing tabs
command! RemoveTrailingTabs %s/\t\+$//e

" Remove trailing spaces and tabs
function! RemoveTrailingChars()
	silent! RemoveTrailingSpaces
	silent! RemoveTrailingTabs
	echo 'Removed trailing whitespace'
endfunction

" Trim trailing whitespace and re-indent the file
function! TrimReindent()
	" Strip whitespace first
	silent! call RemoveTrailingChars()
	" Set no expandtab
	set noexpandtab
	" Save cursor position
	let l:save = winsaveview()
	" Remove all indentation
	execute 'normal! %le'
	execute 'normal! gg=G'
	" Move cursor to original position
	call winrestview(l:save)
	" echo 'Reindented file'
endfunction

" Ctrl-w to strip trailing whitespace
map <C-w> :call RemoveTrailingChars()<CR>

" Ctrl-e to reindent files
map <C-e> :call TrimReindent()<CR>

" Whitespace highlighting
highlight whitespace_bad  guibg=#f1c40f guifg=#2f2f2f
highlight whitespace_odd  guibg=#3498db guifg=#2f2f2f
highlight whitespace_ugly guibg=#e74c3c guifg=#2f2f2f

" Spaces before a tab
let g:w0 = matchadd('whitespace_odd', ' \+\ze\t')
" Tabs that are not at the start of a line
let g:w1 = matchadd('whitespace_bad', '[^\t][^\/\/ ][^# ]\zs\t\+')
" Trailing whitespace
let g:w2 = matchadd('whitespace_ugly', '\s\+$')
" Spaces used for indenting
let g:w3 = matchadd('whitespace_ugly', '^\t*\zs \+')

" Custom whitespace list characters
" set listchars=tab:\|,trail:,nbsp:+

" Set to two bars instead of UTF-8 arrow until iTerm2 GPU accelerated Metal
" renderer on macOS renders it properly
set listchars=tab:\|\|,trail:,nbsp:+
