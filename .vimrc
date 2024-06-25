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


" All the LoadFile() calls are in a very specific order
call LoadFile('misc')
call LoadFile('environment')
call LoadFile('indent')
" call LoadFile('spell')
call LoadFile('buffers')
call LoadFile('encoding')
call LoadFile('syntax')
call LoadFile('backup')
call LoadFile('lightline')

if has('termguicolors') && g:color_16m ==# 'true'
	call LoadFile('truecolor')

	if g:term_program ==# 'iterm2'
		call LoadFile('iterm2')
	endif
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

if has('nvim')
	call LoadFile('neovim')
	call LoadFile('notify')
endif


if g:uname_kernel_name ==# 'Darwin' || (g:uname_kernel_name ==# 'Linux' && g:uname_machine ==# 'x86_64')
	call LoadFile('python')
	call LoadFile('ruby')
endif

call LoadFile('javascript')
call LoadFile('modeline')
call LoadFile('fileformat')
call LoadFile('case')

if g:uname_kernel_name ==# 'Darwin' || (g:uname_kernel_name ==# 'Linux' && g:uname_machine ==# 'x86_64')
	call LoadFile('coc')
	call LoadFile('coc-notify')
endif


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
