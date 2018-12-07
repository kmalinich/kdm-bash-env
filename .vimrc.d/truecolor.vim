" Color scheme
colorscheme brogrammer

" True (24-bit) color support (requires supporting terminal emulator)
if has('termguicolors') && g:color_16m ==# 'true'
	let &t_8f = "\e[38;2;%lu;%lu;%lum"
	let &t_8b = "\e[48;2;%lu;%lu;%lum"
	set termguicolors

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

	" Cursor configuration
	if g:term_program ==# 'iTerm.app'
		" Change iTerm2 cursor shape when changing modes
		if !has('nvim')
			let &t_EI = "\<Esc>]50;CursorShape=1\x7" " Insert  : vertical bar
			let &t_SI = "\<Esc>]50;CursorShape=0\x7" " Normal  : block
			let &t_SR = "\<Esc>]50;CursorShape=2\x7" " Replace : underline
		endif


		" Cursor color variables
		hi bCursor guibg=#3498db
		hi gCursor guibg=#2ecc71
		hi pCursor guibg=#9240ea
		hi rCursor guibg=#e74c3c
		hi wCursor guibg=#e0e0e0
		hi yCursor guibg=#ffe100


		" Mode-specific cursor blinking/colors/shapes

		" Clear any defaults
		set guicursor=
		:autocmd OptionSet guicursor noautocmd set guicursor=

		" Shape
		" Block        : cr n r sm v ve
		" Underline    : c o
		" Vertical bar : ci i

		" Blinking
		" Off : c n
		" On  : ci cr i n o r sm v ve

		" Color
		" Blue   : o
		" Green  : c ci
		" Purple : i
		" Red    : v ve
		" Yellow : cr n r sm

		set guicursor+=c:blinkoff0-blinkon0-blinkwait0-hor20-gCursor
		set guicursor+=ci:blinkoff500-blinkon500-blinkwait10-ver25-gCursor
		set guicursor+=cr:blinkoff500-blinkon500-blinkwait10-block-yCursor
		set guicursor+=i:blinkoff500-blinkon500-blinkwait10-ver25-pCursor
		set guicursor+=n:blinkoff0-blinkon0-blinkwait0-block-yCursor
		set guicursor+=o:blinkoff500-blinkon500-blinkwait10-hor20-bCursor
		set guicursor+=r:blinkoff500-blinkon500-blinkwait10-block-yCursor
		set guicursor+=sm:blinkoff500-blinkon500-blinkwait10-block-yCursor
		set guicursor+=v:blinkoff500-blinkon500-blinkwait10-block-rCursor
		set guicursor+=ve:blinkoff500-blinkon500-blinkwait10-block-rCursor

		" Restore normal cursor style when exiting (in this case, underline)
		augroup fix_cursor
			au VimLeave * set guicursor=a:hor20-yCursor-blinkoff500-blinkon500-blinkwait10
		augroup END
	endif
endif
