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
call LoadFile('misc')
call LoadFile('environment')
call LoadFile('indent')
" call LoadFile('spell')
call LoadFile('buffers')
call LoadFile('polyglot')
call LoadFile('encoding')
call LoadFile('syntax')
call LoadFile('backup')
call LoadFile('lightline')

if has('termguicolors') && g:color_16m ==# 'true'
	call LoadFile('truecolor')
endif

call LoadFile('search')
call LoadFile('scroll')
call LoadFile('titlebar')
call LoadFile('mouse')
call LoadFile('history')

call LoadFile('functions')
call LoadFile('remap')
call LoadFile('whitespace') " whitespace must come before filetype
call LoadFile('filetype')
call LoadFile('neovim')

if g:uname_machine ==# 'x86_64'
	call LoadFile('python')
	call LoadFile('ruby')
endif

call LoadFile('javascript')
call LoadFile('modeline')
call LoadFile('fileformat')
call LoadFile('case')

if g:uname_machine ==# 'x86_64'
	call LoadFile('coc.nvim')
endif


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
