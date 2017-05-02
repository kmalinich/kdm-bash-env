" kdm bash-env
" .vimrc

" Last Modified : Tue 02 May 2017 12:10:46 PM EDT

" Be iMproved, required for Vundle
set nocompatible

" Turn off native filetype handling, required for Vundle
filetype off

" Set the runtime path to include Vundle, and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugin manager
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'amadeus/vim-evokai'
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'
Plugin 'fidian/hexmode'
Plugin 'godlygeek/tabular'
Plugin 'kmalinich/salt-jinja-vim'
Plugin 'marciomazza/vim-brogrammer-theme'
Plugin 'nvie/vim-flake8'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'saltstack/salt-vim'
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-perl/vim-perl'
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/nginx.vim'
Plugin 'vim-scripts/timestamp.vim'

" All of your Plugins must be added before the following line
call vundle#end()         " Required
filetype plugin indent on " Required

" Tabwidth to half size
set ts=2
set sw=2

" Make scrolling and highlighters fast
set ttyfast
"set lazyredraw

" Correct xterm-16mcolor TERM variable
if &term=~'xterm-16mcolor'
	set term=xterm-256color
endif

" Disable line wrapping
set wrap!

" Highlight all Python syntax
let python_highlight_all=1

" Syntax highlighting
syntax on

" True color support
if (has("termguicolors"))
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors

	" Italic support
	let &t_ZH = "\<Esc>[3m"
	let &t_ZR = "\<Esc>[23m"

	" Format comments in italic
	highlight Comment cterm=italic

	" Color scheme
	colorscheme brogrammer

	" iTerm2 cursor shape in insert mode
	let &t_SI = "\<Esc>]50;CursorShape=2\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
"set ruler

" Keep 1000 lines of command line history
set history=1000

" Tell vim to remember certain things when we exit (cursor position)
set viminfo='10,\"100,:20,%,n~/.viminfo

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
	let l:modeline = printf(" vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set :", &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction
nnoremap ml :call AppendModeline()<CR>

" Interfaces file
au BufRead /etc/network/interfaces :set syntax=interfaces

" C
au Filetype c,cpp set expandtab
au Filetype c,cpp set tabstop=4
au Filetype c,cpp set shiftwidth=4
au Filetype c,cpp set autoindent
au Filetype c,cpp let b:comment_leader = '/* '
au Filetype c,cpp set fileformat=unix

" Python
au Filetype python set expandtab
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set autoindent
au Filetype python set fileformat=unix

" HTML
au Filetype html set filetype=xml
au Filetype html set tabstop=4
au Filetype html set softtabstop=4
au Filetype html set shiftwidth=4
au Filetype html set autoindent
au Filetype html let b:comment_leader = '<!--'
au Filetype html set fileformat=unix

" JS
au Filetype javascript let b:comment_leader = '//'
au Filetype javascript set autoindent
au Filetype javascript set fileformat=unix
au Filetype javascript set shiftwidth=2
au Filetype javascript set softtabstop=2
au Filetype javascript set tabstop=2

" Mark extra whitespace in red
highlight bad_whitespace ctermbg=red guibg=red

" Highlight bad whitespace by file type
au Filetype c,cpp,css,html,javascript,perl,php,puppet,python,ruby,sh,spec,vim match bad_whitespace /\s\+$/
"au Filetype c,cpp,javascript,html,python match bad_whitespace /^\t\+/

" Highlight bad whitespace by file extension
au BufRead,BufNewFile *.conf match bad_whitespace /\s\+$/
au BufRead,BufNewFile *.sls match bad_whitespace /\s\+$/

" Fix for editing crontabs with 'crontab -e' on macOS
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Use UTF8 encoding
set encoding=utf8

" vim-airline configuration
set laststatus=2
set ttimeoutlen=10
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts            = 1

" Syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

" eruby checker config
let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of a variable in void context'}

" PHP check config
let g:syntastic_php_checkers = ['php', 'phpmd']
" let g:syntastic_php_phpcs_args = '--tab-width = 4 --warning-severity = 6 --error-severity = 6'
let g:syntastic_php_phpcs_args = ''

" JS check config
let g:syntastic_javascript_checkers    = ['eslint']
let g:syntastic_javascript_eslint_exec = '/usr/local/bin/eslint'
