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

" Append modeline after last line in buffer
function! ModelineAppend()
	let l:modeline = printf(' vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set :', &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')

	" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')

	call append(line('$'), '')
	call append(line('$'), l:modeline)
endfunction
