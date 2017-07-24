" kdm bash-env
" .vimrc / neovim init.vim

" Last Modified : Mon 24 Jul 2017 12:03:18 AM EDT


" Be iMproved, required for Vundle
set nocompatible

" Disable native filetype handling, required for Vundle
filetype off

" Set the runtime path to include Vundle, and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugin manager
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'amadeus/vim-evokai'
Plugin 'ap/vim-css-color'
Plugin 'chr4/nginx.vim'
Plugin 'ervandew/supertab'
Plugin 'fidian/hexmode'
Plugin 'godlygeek/tabular'
Plugin 'kmalinich/salt-jinja-vim'
Plugin 'marciomazza/vim-brogrammer-theme'
Plugin 'moll/vim-node'
Plugin 'nvie/vim-flake8'
Plugin 'othree/html5-syntax.vim'
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
Plugin 'vim-scripts/timestamp.vim'

" All of your plugins must be added before the following line
call vundle#end()

" Re-enable native filetype handling
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Tabwidth to half size
set ts=2
set sw=2

" Make scrolling and highlighters fast
set ttyfast
set lazyredraw

" Correct xterm-16mcolor TERM variable
if &term=~'xterm-16mcolor'
	set term=xterm-256color
endif

" Disable line wrapping
set wrap!

" Highlight all Python syntax
let python_highlight_all=1

" True color support
if (has("termguicolors"))
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors

	" Italic support
	let &t_ZH="\e[3m"
	let &t_ZR="\e[23m"

	" Format comments in italic
	highlight Comment cterm=italic gui=italic

	" Color scheme
	colorscheme brogrammer

	" iTerm2 cursor shape in insert mode
	let &t_SI = "\<Esc>]50;CursorShape=2\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"

	" Fix to restore cursor style when exiting
	au VimLeave * set guicursor=a:block-blinkon0
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
"set ruler

" Keep 1000 lines of command line history
set history=1000

" Tell vim to remember certain things when we exit (cursor position)
" set viminfo='10,\"100,:20,%,n~/.nviminfo

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
	let l:modeline = printf("vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set : ", &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction
nnoremap ml :call AppendModeline()<CR>

" Super-re-indent the file
function! SuperReIndent()
	call StripTrailingWhitespace()
	" Save cursor position
	let l:save = winsaveview()
	" Remove all indentation
	:execute 'normal! %le'
	:execute 'normal! gg=G'
	" Move cursor to original position
	call winrestview(l:save)
	" echo "Reindented file"
endfunction
nnoremap re :call SuperReIndent()<CR>

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
nnoremap rw :call StripTrailingWhitespace()<CR>


" Mark extra whitespace in red
highlight bad_whitespace ctermbg=red guibg=red

" Interfaces file
au BufRead /etc/network/interfaces :set syntax=interfaces

" C
au Filetype c,cpp let b:comment_leader = '/* '
au Filetype c,cpp set autoindent
au Filetype c,cpp set expandtab
au Filetype c,cpp set fileformat=unix
au Filetype c,cpp set shiftwidth=2
au Filetype c,cpp set softtabstop=2
au Filetype c,cpp set tabstop=2

" CSS
au Filetype css let b:comment_leader = '/* '
" au Filetype css set autoindent
au Filetype css set expandtab!
au Filetype css setlocal expandtab!
au Filetype css set fileformat=unix

" HTML
au Filetype html let b:comment_leader = '<!-- '
" au Filetype html set autoindent
au Filetype html set expandtab!
au Filetype html setlocal expandtab!
au Filetype html set fileformat=unix

" JS
au Filetype javascript let b:comment_leader = '// '
au Filetype javascript set expandtab!
au Filetype javascript setlocal expandtab!
au Filetype javascript set fileformat=unix

" nginx
au Filetype nginx let b:comment_leader = '# '
" au Filetype nginx set autoindent
au Filetype nginx set expandtab!
au Filetype nginx setlocal expandtab!
au Filetype nginx set fileformat=unix

" PHP
au Filetype php let b:comment_leader = '// '
" au Filetype php set autoindent
au Filetype php set expandtab!
au Filetype php setlocal expandtab!
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
au Filetype sh set expandtab!
au Filetype sh setlocal expandtab!
au Filetype sh set fileformat=unix

" VMWare vmx
au BufRead *.vmx :set filetype=cfg

" Fix for editing crontabs with 'crontab -e' on macOS
au BufEnter /private/tmp/crontab.* setl backupcopy=yes


" Highlight bad whitespace by file type
au Filetype * match bad_whitespace /\s\+$/


" Temporarily deactivate mouse handling in ViM8/neoViM while I figure it out
set mouse=


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

" Neovim Python config
let g:python_host_prog  = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.6'
