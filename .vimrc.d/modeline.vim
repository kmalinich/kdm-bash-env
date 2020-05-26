scriptencoding utf-8


" Enable secure modelines
set secure


" Whitelisted modeline options
let g:secure_modelines_allowed_items = [
	\ "expandtab",   "et",  "noexpandtab", "noet",
	\ "filetype",    "ft",
	\ "foldmethod",  "fdm",
	\ "readonly",    "ro",  "noreadonly",  "noro",
	\ "rightleft",   "rl",  "norightleft", "norl",
	\ "shiftwidth",  "sw",
	\ "softtabstop", "sts",
	\ "tabstop",     "ts",
	\ "textwidth",   "tw",
	\ ]

" Warn about invalid modeline options
let g:secure_modelines_verbose = 0


" Only check the first two or last two lines for modelines
set modelines=2

let g:secure_modelines_modelines = 2


" Append modeline after last line in buffer
function! ModelineAppend()
	let l:modeline = printf(' vim: set filetype=%s ts=%d sw=%d tw=%d %set :', &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')

	" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')

	call append(line('$'), '')
	call append(line('$'), l:modeline)
endfunction


" vim: set filetype=vim ts=2 sw=2 tw=78 noet :
