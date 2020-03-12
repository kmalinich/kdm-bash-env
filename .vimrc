" Load files from ~/.vimrc.d
function! LoadFile(name)
	let l:path = $HOME . '/.vimrc.d/' . a:name . '.vim'

	if !filereadable(l:path)
		echo 'Failed to load: ' . l:path
	endif

	if filereadable(l:path)
		:exec ':source ' . l:path
	endif
endfunction


" These are in a specific order
call LoadFile('environment')
call LoadFile('indent')
call LoadFile('spell')
call LoadFile('coc.nvim')
call LoadFile('polyglot')
call LoadFile('encoding')
call LoadFile('syntax')
call LoadFile('backup')
call LoadFile('truecolor')
call LoadFile('search')
call LoadFile('scroll')
call LoadFile('titlebar')
call LoadFile('buffers')
call LoadFile('misc')
call LoadFile('mouse')
call LoadFile('history')
call LoadFile('illuminate')
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
call LoadFile('modeline')
call LoadFile('fileformat')
call LoadFile('case')


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
