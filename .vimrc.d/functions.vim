scriptencoding utf-8


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

" The PC is fast enough, do syntax highlight syncing from start out to 200 lines
augroup vimrc_sync_fromstart
	au!
	au BufEnter * :syntax sync maxlines=200
augroup END


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
