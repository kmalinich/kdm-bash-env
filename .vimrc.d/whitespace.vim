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
highlight whitespace_blu guibg=#3498db guifg=#000000
highlight whitespace_orn guibg=#e67e22 guifg=#ffffff
highlight whitespace_red guibg=#e74c3c guifg=#000000
highlight whitespace_ylw guibg=#f1c40f guifg=#000000

" Spaces before a tab
let w:m0 = matchadd('whitespace_blu', ' \+\ze\t')
" Tabs that are not at the start of a line or after an existing tab
let w:m1 = matchadd('whitespace_ylw', '[^\t][^\/\/ ][^# ]\zs\t\+')
" Trailing whitespace
let w:m2 = matchadd('whitespace_orn', '\s\+$')
" Spaces used for indenting
let w:m3 = matchadd('whitespace_red', '^\t*\zs \+')


function! DisableSpaceIndentHighlight()
	call clearmatches()

	" Spaces before a tab
	let w:m0 = matchadd('whitespace_blu', ' \+\ze\t')
	" Tabs that are not at the start of a line or after an existing tab
	let w:m1 = matchadd('whitespace_ylw', '[^\t][^\/\/ ][^# ]\zs\t\+')
	" Trailing whitespace
	let w:m2 = matchadd('whitespace_orn', '\s\+$')
endfunction


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
