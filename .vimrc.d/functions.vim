" Automatically reload .vimrc on changes
command! ReloadVimrc source ~/.vimrc
augroup vimrc_reload
	" Imperative to clear existing autocmds here, or Mr. Slowly shows up
	au!
	au BufWritePost ~/.vimrc source ~/.vimrc
augroup END

" Remember cursor position
augroup vimrc_remember_cursor_position
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc_sync_fromstart
	au BufEnter * :syntax sync maxlines=200
augroup END


" Increase lint delay to 3000ms (for large files)
function! ALELintSlow()
	let g:ale_lint_delay = 3000
	echo 'Set ALE lint delay to 3 seconds'
endfunction

" Set lint delay to 250ms (for small files)
function! ALELintFast()
	let g:ale_lint_delay = 250
	echo 'Set ALE lint delay to 250ms'
endfunction

" Append modeline after last line in buffer
function! ModelineAppend()
	let l:modeline = printf('vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set :', &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction

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
