" Pull in some environment variables
let g:color_16m=$BASH_ENV_COLOR_16M
let g:term_program=$TERM_PROGRAM
let g:term_type=$TERM


" Enable native filetype handling
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Tabwidth to half size
set tabstop=2
set shiftwidth=2

" Make scrolling and highlighters fast
" set lazyredraw
set ttyfast

" Disable line wrapping
set wrap!

" Temporarily deactivate mouse handling in ViM8/neoViM while I figure it out
set mouse=

" Use UTF8 encoding
set encoding=utf8

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 10000 lines of command line history
set history=10000

" Tell vim to remember certain things when we exit (like cursor position)
if !has('nvim')
	set viminfo='10,\"100,:20,%,n~/.viminfo
endif

" Delete comment character when joining commented lines
set formatoptions+=j


" True (24-bit) color support (requires supporting terminal emulator)
if has('termguicolors') && g:color_16m ==# 'true'
	let &t_8f = "\e[38;2;%lu;%lu;%lum"
	let &t_8b = "\e[48;2;%lu;%lu;%lum"
	set termguicolors

	" Color scheme
	colorscheme brogrammer

	" Italic support (requires proper ~/.terminfo)
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
endif


if g:term_program ==# 'iTerm.app'
	" Change iTerm2 cursor shape when changing modes
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	let &t_SI = "\<Esc>]50;CursorShape=2\x7"
	let &t_SR = "\<Esc>]50;CursorShape=1\x7"

	" Fix to restore cursor style when exiting
	au VimLeave * set guicursor=a:hor30-iCursor-blinkwait250-blinkon250-blinkoff250
endif


" Restore cursor position properly
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END


" Append modeline after last line in buffer
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
function! AppendModeline()
	let l:modeline = printf('vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set : ', &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction
nnoremap ml :call AppendModeline()<CR>

" Super-re-indent the file
function! SuperReIndent()
	" Strip whitespace first
	call StripTrailingWhitespace()
	" Set no expandtab
	set noexpandtab
	" Save cursor position
	let l:save = winsaveview()
	" Remove all indentation
	:execute 'normal! %le'
	:execute 'normal! gg=G'
	" Move cursor to original position
	call winrestview(l:save)
	" echo "Reindented file"
endfunction

function! StripTrailingWhitespace()
	" Save cursor position
	let l:save = winsaveview()
	" Remove trailing whitespace
	%s/\s\+$//e
	" Remove trailing tabs
	%s/\t\+$//e
	" Move cursor to original position
	call winrestview(l:save)
	" echo "Removed trailing whitespace"
endfunction


" Shortcut key maps
" Ctrl-E to reindent files
map <C-e> :call SuperReIndent()<CR>
" Ctrl-H Enable/disable code concealing
map <C-h> :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
" Ctrl-J and Ctrl-K to navigate ale errors
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
" Ctrl-T to toggle NERDTree
map <C-t> :NERDTreeToggle<CR>
" Ctrl-W to strip trailing whitespace
map <C-w> :call StripTrailingWhitespace()<CR>


" Default set no expandtab
set noexpandtab

" Interfaces file
au BufRead /etc/network/interfaces set fileformat=unix
au BufRead /etc/network/interfaces set filetype=interfaces
au BufRead /etc/network/interfaces set syntax=interfaces

" C
au Filetype c,cpp let b:comment_leader = '/* '
au Filetype c,cpp set autoindent
au Filetype c,cpp set expandtab
au Filetype c,cpp set fileformat=unix
au Filetype c,cpp set softtabstop=2

" CSS
au Filetype css let b:comment_leader = '/* '
" au Filetype css set autoindent
au Filetype css set fileformat=unix

" HTML
au Filetype html let b:comment_leader = '<!-- '
" au Filetype html set autoindent
au Filetype html set fileformat=unix

" JS
au Filetype javascript let b:comment_leader = '// '
au Filetype javascript set fileformat=unix

" nginx
au Filetype nginx let b:comment_leader = '# '
" au Filetype nginx set autoindent
au Filetype nginx set fileformat=unix

" PHP
au Filetype php let b:comment_leader = '// '
" au Filetype php set autoindent
au Filetype php set fileformat=unix

" Python
au Filetype python let b:comment_leader = '# '
au Filetype python set autoindent
au Filetype python set expandtab
au Filetype python set fileformat=unix
au Filetype python set shiftwidth=4
au Filetype python set softtabstop=4
au Filetype python set tabstop=4

" sh/bash
au Filetype sh let b:comment_leader = '# '
" au Filetype sh set autoindent
au Filetype sh set fileformat=unix

" sls (salt)
au BufRead *.sls let b:comment_leader = '# '
" au BufRead *.sls set autoindent
au BufRead *.sls set fileformat=unix

" VMWare vmx
au BufRead *.vmx :set filetype=cfg

" Fix for editing crontabs with 'crontab -e' on macOS
au BufEnter /private/tmp/crontab.* setl backupcopy=yes


" Mark extra whitespace in red
highlight bad_whitespace ctermbg=red guibg=red

" Highlight bad whitespace by file type
au Filetype * match bad_whitespace /\s\+$/


" Neovim Python config
let g:python_host_prog  = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.6'


" ale (Asynchronous Lint Engine) shellcheck config
" Disable 'Can't follow non-constant source' and 'file was not specified as input' errors on sourced scripts
let g:ale_sh_shellcheck_options = '-e 1090 -e SC1091'

" ale (Asynchronous Lint Engine) message config
" let g:ale_echo_msg_error_str   = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'


" ale (Asynchronous Lint Engine) symbol config
let g:ale_sign_error   = ''
let g:ale_sign_warning = ''


" airline/powerline config
set laststatus=2
set noshowmode
let g:airline_theme = 'airlineish'


" airline/powerline symbol config
let g:airline_powerline_fonts = 1
let g:airline_left_sep        = ''
let g:airline_right_sep       = ''
let g:airline_right_alt_sep   = ''

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.branch     = ''
let g:airline_symbols.linenr     = ''
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.readonly   = ''
let g:airline_symbols.whitespace = 'Ξ'


" airline/powerline extension config
let g:airline#extensions#ale#enabled        = 1
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tagbar#enabled     = 1
let g:airline#extensions#virtualenv#enabled = 1
" Straight tabs
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep     = ' '


" airline/powerline extension symbol config
let g:airline#extensions#branch#prefix     = ''
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline#extensions#readonly#symbol   = '⊘'


" Python plugin config
" Highlight all Python syntax
let g:python_highlight_all=1


" JavaScript plugin config
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" JavaScript plugin code concealing config
let g:javascript_conceal_NaN       = 'ℕ'
let g:javascript_conceal_function  = 'ƒ'
let g:javascript_conceal_null      = 'ø'
let g:javascript_conceal_prototype = '¶'
let g:javascript_conceal_return    = '⇚'
let g:javascript_conceal_static    = '•'
let g:javascript_conceal_super     = 'Ω'
let g:javascript_conceal_this      = '@'
let g:javascript_conceal_undefined = '¿'

" Enable code concealing
set conceallevel=1


" vim: set syntax=vim filetype=vim ts=2 sw=2 tw=78 noet :
