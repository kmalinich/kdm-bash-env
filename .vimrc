" Load files from ~/.vimrc.d
function! LoadFile(name)
	let l:path = $HOME.'/.vimrc.d/' . a:name . '.vim'

	if !filereadable(l:path)
		echo 'Failed to load: '.l:path
	endif

	if filereadable(l:path)
		:exec ':source ' . l:path
	endif
endfunction

call LoadFile('indent')
call LoadFile('polyglot')
call LoadFile('encoding')
call LoadFile('environment')
call LoadFile('syntax')
call LoadFile('backup')
call LoadFile('search')
call LoadFile('scroll')
call LoadFile('titlebar')
call LoadFile('buffers')
call LoadFile('misc')
call LoadFile('history')
call LoadFile('truecolor')
call LoadFile('functions')
call LoadFile('remap')
call LoadFile('filetype')
call LoadFile('whitespace')
call LoadFile('neovim')
call LoadFile('python')
call LoadFile('ruby')
call LoadFile('javascript')
call LoadFile('ale')
call LoadFile('airline')
call LoadFile('autosave')
call LoadFile('modeline')
call LoadFile('spell')
call LoadFile('fileformat')

" vim: set syntax=vim filetype=vim ts=2 sw=2 tw=0 noet :
