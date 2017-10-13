" Force enable modeline usage
set modeline

" Only check the first two or last two lines for modelines
set modelines=2

" Append modeline after last line in buffer
function! ModelineAppend()
	let l:modeline = printf(' vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set :', &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')

	" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')

	call append(line('$'), '')
	call append(line('$'), l:modeline)
endfunction
