" Keep 1000 lines of command history
set history=1000

" Keep 1000 lines of undo history
set undolevels=1000

" Tell vim to remember certain things when we exit (like cursor position)
if !has('nvim')
	set viminfo='10,\"100,:20,%,n~/.viminfo
endif
