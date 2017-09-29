" Keep 1000 lines of command history
set history=1000

" Keep 1000 lines of undo history
set undolevels=1000

" If neovim, read/write shada on CursorHold
if has('nvim')
	function! SyncShaDA()
		rshada|wshada
	endfunction

	augroup cursor_shada
		autocmd!
		autocmd CursorHold * :call SyncShaDA()
	augroup END
else
	" Remember certain things when we exit (like cursor position)
	set viminfo='10,\"100,:20,%,n~/.vim/viminfo
endif
