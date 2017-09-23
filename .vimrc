" Use UTF8 encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8
" set bomb
" set binary

if !exists('autocommands_loaded')
	let g:autocommands_loaded = 1
endif

" Pull in some environment variables
let g:color_16m = $BASH_ENV_COLOR_16M

let g:domain      = $DOMAIN
let g:domain_full = $DOMAIN_FULL

let g:home = $HOME

let g:host_ip     = $HOST_IP
let g:host_short  = $HOST_SHORT
let g:host_sub    = $HOST_SUB

let g:pwd           = $PWD
let g:pwd_custom    = $PWD_CUSTOM
let g:pwd_final     = $PWD_FINAL
let g:pwd_fmt       = $PWD_FMT
let g:pwd_fmt_depth = $PWD_FMT_DEPTH

let g:term_program = $TERM_PROGRAM
let g:term_type    = $TERM


" Shell variable
if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/usr/local/bin/bash
endif

" Configure proper make binary
let g:make = 'gmake'
if exists('make')
	let g:make = 'make'
endif


" Disable system buffers menu
let g:no_buffers_menu = 1

" Enable native filetype handling
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Tabwidth to half size
set shiftwidth=2
set softtabstop=0
set tabstop=2
" Default set no expandtab
set noexpandtab

" Enable code concealing
" set conceallevel=1

" Centralize backup and temporary storage
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Enable hidden buffers
set hidden

" Disable previous search highlight...
set nohlsearch
" ... but still highlight during searches
set incsearch

" Blink search highlight for 5 seconds
set matchtime=5

" Case-insensitive search...
set ignorecase
" ... unless there's a capital letter
set smartcase

" Search mappings
" If off-screen, scroll the next find to the center of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Show matching brackets
set showmatch

" Keep at least 2 lines above/below
set scrolloff=2
" Keep at least 2 lines left/right
set sidescrolloff=2

" Automatically change into the directory the current file is in
" set autochdir

" Set the terminal title to something like '[VIM] kdm-mbp.z1:~/.vimrc [+]'
let g:file_path_format = substitute(expand('%:p'), g:home, '~', '')
set titlestring=\[VIM\]\ %{host_sub}:%{file_path_format}\ %m
set title

" Make scrolling and highlighters fast
set lazyredraw
if !has('nvim')
	set ttyfast
endif

" Disable line wrapping
set wrap!

" Temporarily deactivate mouse handling in ViM8/neoViM while I figure it out
set mouse=

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 1000 lines of command history
set history=1000

" Keep 1000 lines of undo history
set undolevels=1000

" Tell vim to remember certain things when we exit (like cursor position)
if !has('nvim')
	set viminfo='10,\"100,:20,%,n~/.viminfo
endif

" Delete comment character when joining commented lines
set formatoptions+=j

" Shorten messages and don't show intro
set shortmess=atI

" Preferred file format order
set fileformats=unix,dos,mac


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


" Cursor colors
hi bCursor guibg=#3498db
hi gCursor guibg=#2ecc71
hi pCursor guibg=#6c71c4
hi rCursor guibg=#e74c3c
hi wCursor guibg=#e0e0e0
hi yCursor guibg=#f1c40f

" Cursor configuration
if g:term_program ==# 'iTerm.app'
	" Change iTerm2 cursor shape when changing modes
	if !has('nvim')
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		let &t_SI = "\<Esc>]50;CursorShape=2\x7"
		let &t_SR = "\<Esc>]50;CursorShape=1\x7"
	endif

	" Mode-specific cursor blinking/colors/shapes
	set guicursor+=c:hor100-blinkwait10-blinkoff500-blinkon500-rCursor
	set guicursor+=n:hor100-blinkon0-yCursor
	set guicursor+=i:block-blinkwait10-blinkon500-blinkoff500-rCursor
	set guicursor+=o:hor100-blinkwait10-blinkoff500-blinkon500-bCursor
	set guicursor+=r-cr:ver100-blinkwait10-blinkoff500-blinkon500-gCursor
	set guicursor+=v:block-blinkwait10-blinkoff500-blinkon500-pCursor
	set guicursor+=sm:block-blinkwait10-blinkoff500-blinkon500-yCursor

	" Restore normal cursor style when exiting (in this case, underline)
	augroup fix_cursor
		au VimLeave * set guicursor=a:hor100-blinkwait10-blinkon500-blinkoff500-wCursor
	augroup END
endif

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc_sync_fromstart
	" au!
	au BufEnter * :syntax sync maxlines=200
augroup END

" Automatically reload .vimrc on changes
augroup vimrc_reload
	" Imperative to clear existing autocmds here, or Mr. Slowly shows up
	au!
	au BufWritePost ~/.vimrc source ~/.vimrc
augroup END

" Remember cursor position
augroup vimrc_remember_cursor_position
	" au!
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Add a command for loading .vimrc completely
command! ReloadVimrc source ~/.vimrc


" Increase lint delay to 3000ms (for large files)
function! ALELintSlow()
	let g:ale_lint_delay = 3000
	echo 'Set ALE lint delay to 3 seconds'
endfunction

" Set lint delay to 250ms (for small files)
function! ALELintFast()
	let g:ale_lint_delay = 250
	echo 'Set ALE lint delay to 250ms'
endfunction


" Append modeline after last line in buffer
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
function! AppendModeline()
	let l:modeline = printf('vim: set syntax=%s filetype=%s ts=%d sw=%d tw=%d %set : ', &syntax, &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction

" Super-re-indent the file
function! SuperReIndent()
	" Strip whitespace first
	silent! call WhitespaceTrim()
	" Set no expandtab
	set noexpandtab
	" Save cursor position
	let l:save = winsaveview()
	" Remove all indentation
	execute 'normal! %le'
	execute 'normal! gg=G'
	" Move cursor to original position
	call winrestview(l:save)
	" echo 'Reindented file'
endfunction

" Remove trailing whitespace
command! WhitespaceSpaces %s/\s\+$//e
" Remove trailing tabs
command! WhitespaceTabs %s/\t\+$//e

function! WhitespaceTrim()
	" Trim whitespace
	silent! WhitespaceSpaces
	silent! WhitespaceTabs
	echo 'Removed trailing whitespace'
endfunction


" Shortcut key maps

" pbcopy for macOS copy/paste
if has('macunix')
	vmap <C-x> :!pbcopy<CR>
	vmap <C-c> :w !pbcopy<CR><CR>

	" Make it so copy/paste to system works from vim
	set clipboard=unnamed
endif

" Oops-Caps-Lock abbreviations
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Qall qall
cnoreabbrev Qall! qall!
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev WQ wq
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" jj to escape in insert mode
inoremap jj <Esc>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Remap semicolon to colon in normal mode (pinky thanks you)
nore ; :
" nore , ;

" Ctrl-B to delete to the end of line in insert mode
inoremap <C-b> <Esc>lDa
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
map <C-w> :call WhitespaceTrim()<CR>

" Bind F8 to fixing problems with ale
nmap <F8> <Plug>(ale_fix)

" Map \ml to append modeline
nnoremap ml :call AppendModeline()<CR>

" Map \as to increase lint delay
nnoremap as :call ALELintSlow()<CR>
" Map \af to decrease lint delay
nnoremap af :call ALELintFast()<CR>

" Disable replace mode, which turns on in bad terminals for some reason
nnoremap R <Nop>
" Disable Ex mode
noremap Q <Nop>

" Tab navigation like Firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" This is for working across multiple xterms and/or gvims
" Transfer/read and write one block of text between vim sessions (capture whole line):
" Append
" nmap ;a :. w! >>~/.vimxfer<CR>
" Read
" nmap ;r :r ~/.vimxfer<CR>
" Write
" nmap ;w :. w! ~/.vimxfer<CR>


" C
au Filetype c,cpp let b:comment_leader = '/* '
au Filetype c,cpp set autoindent
au Filetype c,cpp set expandtab
au Filetype c,cpp set softtabstop=2

" CSS
au Filetype css let b:comment_leader = '/* '

" HTML
au Filetype html let b:comment_leader = '<!-- '

" JS
au Filetype javascript let b:comment_leader = '// '

" nginx
au Filetype nginx let b:comment_leader = '# '

" PHP
au Filetype php let b:comment_leader = '// '

" Python
au Filetype python let b:comment_leader = '# '
au Filetype python set autoindent
au Filetype python set expandtab
au Filetype python set shiftwidth=4
au Filetype python set softtabstop=4
au Filetype python set tabstop=4

" sh/bash
au Filetype sh let b:comment_leader = '# '


" Interfaces file
augroup ft_interfaces
	au BufRead /etc/network/interfaces set filetype=interfaces
	au BufRead /etc/network/interfaces set syntax=interfaces
augroup END

" Laravel (php) environment config
augroup ft_env
	au BufRead .env* set filetype=cfg
	au BufRead .env* set noexpandtab
augroup END

" JSON family
augroup ft_json
	au BufRead *.json set filetype=json
	au BufRead *.json set noexpandtab

	au BufRead *csslintrc set filetype=json
	au BufRead *csslintrc set noexpandtab

	au BufRead *eslintrc set filetype=json
	au BufRead *eslintrc set noexpandtab

	au BufRead *htmlhintrc set filetype=json
	au BufRead *htmlhintrc set noexpandtab

	au BufRead *jshintrc set filetype=json
	au BufRead *jshintrc set noexpandtab

	au BufRead *prettierrc set filetype=json
	au BufRead *prettierrc set noexpandtab

	au BufRead *proselintrc set filetype=json
	au BufRead *proselintrc set noexpandtab

	au BufRead *stylelintrc set filetype=json
	au BufRead *stylelintrc set noexpandtab

	au BufRead composer.lock set filetype=json
	au BufRead composer.lock set noexpandtab
augroup END

" systemd unit files
augroup ft_systemd
	au BufRead *.mount let b:comment_leader = '# '
	au BufRead *.mount set filetype=systemd

	au BufRead *.service let b:comment_leader = '# '
	au BufRead *.service set filetype=systemd

	au BufRead *.socket let b:comment_leader = '# '
	au BufRead *.socket set filetype=systemd

	au BufRead *.target let b:comment_leader = '# '
	au BufRead *.target set filetype=systemd

	au BufRead *.timer let b:comment_leader = '# '
	au BufRead *.timer set filetype=systemd
augroup END

" Salt sls
augroup ft_sls
	au BufRead *.sls let b:comment_leader = '# '
	au BufRead *.sls set filetype=sls
augroup END

" Varnish vcl
augroup ft_vcl
	au BufRead *.vcl* let b:comment_leader = '# '
	au BufRead *.vcl* set filetype=vcl
	au BufRead *.vcl* set noexpandtab

	au BufRead *.vcl.jinja let b:comment_leader = '# '
	au BufRead *.vcl.jinja set filetype=vcl
	au BufRead *.vcl.jinja set noexpandtab
augroup END

" VMWare vmx
augroup ft_vmx
	au BufRead *.vmx set filetype=cfg
augroup END

" YAML family
augroup ft_yaml
	au BufRead *.yaml let b:comment_leader = '# '
	au BufRead *.yaml set filetype=yaml

	au BufRead *.yml let b:comment_leader = '# '
	au BufRead *.yml set filetype=yaml

	au BufRead *gemrc let b:comment_leader = '# '
	au BufRead *gemrc set filetype=yaml
augroup END


" Fix for editing crontabs with 'crontab -e' on macOS
augroup ft_crontab_macos
	au BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup END


" Whitespace highlighting
highlight whitespace_bad  guibg=#f1c40f guifg=#2f2f2f
highlight whitespace_ugly guibg=#e74c3c guifg=#2f2f2f

" Tabs that are not at the start of a line
let g:w0 = matchadd('whitespace_bad', '[^\t]\zs\t\+')
" Spaces before a tab
let g:w1 = matchadd('whitespace_bad', ' \+\ze\t')
" Trailing whitespace
let g:w2 = matchadd('whitespace_ugly', '\s\+$')
" Spaces used for indenting
let g:w3 = matchadd('whitespace_ugly', '^\t*\zs \+')


" Custom whitespace list characters
set listchars=tab:\|,trail:,nbsp:+


" Neovim Python config
let g:python_host_prog  = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.6'


" ale (Asynchronous Lint Engine) base config
" Set default lint delay to 250ms
let g:ale_lint_delay = 250
" Configure filetype-specific fixers
let g:ale_fixers = { 'css': [ 'prettier', 'stylelint' ], 'scss': [ 'prettier', 'stylelint' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ] }
" Configure filetype-specific linters
let g:ale_linters = { 'scss': [ 'stylelint' ], 'html': [ 'htmlhint', 'proselint', 'tidy' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ] }


" ale (Asynchronous Lint Engine) phpmd config
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,design,naming,unusedcode'


" ale (Asynchronous Lint Engine) shellcheck config
" Disable [SC1090] Can't follow non-constant source
" Disable [SC1091] file was not specified as input
" Disable [SC2039] In POSIX sh, something is undefined
" Disable [SC2059] Don't use variables in the printf format string
" Disable [SC2068] Double quote array expansions to avoid re-splitting elements
let g:ale_sh_shellcheck_options = '-s bash -e SC1090 -e SC1091 -e SC2039 -e SC2059 -e SC2068'


" ale (Asynchronous Lint Engine) HTML tidy config
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options    = '-q -e -language en -c ~/.tidy.conf'


" ale (Asynchronous Lint Engine) gutter config
" let g:ale_sign_column_always = 1

" ale (Asynchronous Lint Engine) symbol config
let g:ale_sign_error   = '✗'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign   guibg=#2f2f2f guifg=#e74c3c
highlight ALEWarningSign guibg=#2f2f2f guifg=#f1c40f


" airline/powerline base config
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
let g:polyglot_disabled    = [ 'python' ]
let g:python_highlight_all = 1


" Ruby plugin config
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails             = 1


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


" vim-polyglot config
" Disable javascript
let g:polyglot_disabled = [ 'javascript' ]


" vim: set syntax=vim filetype=vim ts=2 sw=2 tw=78 noet :
