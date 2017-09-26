" True (24-bit) color support (requires supporting terminal emulator)
if has('termguicolors') && g:color_16m ==# 'true'
	let &t_8f = "\e[38;2;%lu;%lu;%lum"
	let &t_8b = "\e[48;2;%lu;%lu;%lum"
	set termguicolors

	" Color scheme
	colorscheme brogrammer

	" Italic support (requires neovim and proper ~/.terminfo)
	if has('nvim')
		let &t_ZH="\e[3m"
		let &t_ZR="\e[23m"

		" Format comments in italic
		highlight Comment cterm=italic gui=italic

		" Show visible whitespace
		set list

		" Ctrl-L to enable/disable whitespace indicators
		map <C-l> :set list!<CR>
	endif

	" Cursor colors
	hi bCursor guibg=#3498db
	hi gCursor guibg=#2ecc71
	hi pCursor guibg=#6c71c4
	hi rCursor guibg=#e74c3c
	hi wCursor guibg=#e0e0e0
	hi yCursor guibg=#f1c40f

	" Cursor configuration
	if g:term_program ==# 'iTerm.app'
		" Change iTerm2 cursor shape when changing modes
		if !has('nvim')
			let &t_EI = "\<Esc>]50;CursorShape=0\x7"
			let &t_SI = "\<Esc>]50;CursorShape=2\x7"
			let &t_SR = "\<Esc>]50;CursorShape=1\x7"
		endif

		" Mode-specific cursor blinking/colors/shapes
		set guicursor+=c:hor100-blinkwait10-blinkoff500-blinkon500-rCursor
		set guicursor+=n:hor100-blinkon0-yCursor
		set guicursor+=i:block-blinkwait10-blinkon500-blinkoff500-rCursor
		set guicursor+=o:hor100-blinkwait10-blinkoff500-blinkon500-bCursor
		set guicursor+=r-cr:ver100-blinkwait10-blinkoff500-blinkon500-gCursor
		set guicursor+=v:block-blinkwait10-blinkoff500-blinkon500-pCursor
		set guicursor+=sm:block-blinkwait10-blinkoff500-blinkon500-yCursor

		" Restore normal cursor style when exiting (in this case, underline)
		augroup fix_cursor
			au VimLeave * set guicursor=a:hor100-blinkwait10-blinkon500-blinkoff500-wCursor
		augroup END
	endif
endif
