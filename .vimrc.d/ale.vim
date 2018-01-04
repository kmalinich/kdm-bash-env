scriptencoding utf-8


" Set lint delay to value of argument or 1ms * number of lines in file, minimum 100ms
function ALELintDelay(...)
	" If argument provided, set lint delay to argument value
	if exists('a:1')
		let g:ale_lint_delay = a:1
	else
		" Set lint delay to 1ms * number of lines in file, minimum 100ms
		if line('$') > 99
			let g:ale_lint_delay = line('$')
		else
			let g:ale_lint_delay = 100
		endif
	endif

	echo 'Set ALE lint delay to ' . g:ale_lint_delay . 'ms'
endfunction


" \af : Set ale lint delay 250ms
nnoremap af :call ALELintDelay(250)<CR>

" \as : Set ale lint delay to 5000ms
nnoremap as :call ALELintDelay(5000)<CR>


" Ctrl-f : Run ale fixer
nmap <silent> <C-f> <Plug>(ale_fix)

" Ctrl-k/Ctrl-k : Navigate ale errors
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)


" ale (Asynchronous Lint Engine) base config
" Set default lint delay to number of lines in file
let g:ale_lint_delay = 1000
augroup ale_lintdelay_set
	au BufRead * silent call ALELintDelay()
augroup END

" Configure filetype-specific fixers
let g:ale_fixers = { 'css': [ 'prettier', 'stylelint' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ], 'python': [ 'isort', 'yapf' ], 'scss': [ 'prettier', 'stylelint' ] }

" Configure filetype-specific linters
let g:ale_linters = { 'html': [ 'htmlhint', 'proselint', 'tidy' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ], 'scss': [ 'stylelint' ] }

" ale (Asynchronous Lint Engine) phpmd config
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,design,naming,unusedcode'

" ale (Asynchronous Lint Engine) shellcheck config
" Disable [SC1090] Can't follow non-constant source
" Disable [SC1117] Backslash is literal in "\e". Prefer explicit escaping: "\\e".
" Disable [SC2059] Don't use variables in the printf format string
let g:ale_sh_shellcheck_options = '-e SC1090 -e SC1117 -e SC2059 -s bash -x'

let g:ale_python_pylint_options = '-d line-too-long'

" ale (Asynchronous Lint Engine) HTML tidy config
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options    = '-q -e -language en'

" ale (Asynchronous Lint Engine) gutter config
let g:ale_sign_column_always = 0

" ale (Asynchronous Lint Engine) symbol config
highlight ALEErrorSign   guibg=#2f2f2f guifg=#e74c3c
highlight ALEWarningSign guibg=#2f2f2f guifg=#f1c40f
let g:ale_sign_error   = '✗'
let g:ale_sign_warning = '⚠'
