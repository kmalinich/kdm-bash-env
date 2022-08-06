scriptencoding utf-8


" Enable cursorline
set cursorline

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


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
