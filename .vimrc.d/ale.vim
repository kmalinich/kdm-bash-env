scriptencoding utf-8


" ale (Asynchronous Lint Engine) configuration


" Base/misc
let g:ale_completion_enabled = 1
let g:ale_lint_delay         = 1000
let g:ale_set_balloons       = 1
let g:ale_sign_column_always = 0


" Set lint delay to value of argument, or (number of lines in file * 2) ms, minimum 100 ms
function! ALELintDelay(...)
	" If argument provided, set lint delay to argument value
	if exists('a:1')
		let g:ale_lint_delay = a:1
	else
		" Set lint delay to (number of lines in file * 2) ms, minimum 100 ms
		if line('$') > 99
			let g:ale_lint_delay = line('$') * 2
		else
			let g:ale_lint_delay = 100
		endif
	endif

	echo 'Set ALE lint delay to ' . g:ale_lint_delay . ' ms'
endfunction


" \af : Set ale lint delay to  250 ms
" \as : Set ale lint delay to 5000 ms
nnoremap af :call ALELintDelay(250)<CR>
nnoremap as :call ALELintDelay(5000)<CR>

" Ctrl-f : Run fixer
nmap <silent> <C-f> <Plug>(ale_fix)

" Ctrl-j/Ctrl-k : Navigate errors
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)


" Base configuration
" Set default lint delay to number of lines in file
augroup ale_lintdelay_set
	au BufRead * silent call ALELintDelay()
augroup END

" Warn of trailing whitespace
let g:ale_warn_about_trailing_whitespace = 1


" Symbols
highlight ALEErrorSign   guibg=#2f2f2f guifg=#e74c3c
highlight ALEWarningSign guibg=#2f2f2f guifg=#f1c40f

let g:ale_sign_error   = '✗'
let g:ale_sign_warning = '⚠'

let g:ale_echo_msg_error_str   = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format      = '[%severity% ] [%linter%] [%...code...%] %s'


" Disable linting minified files
let g:ale_pattern_options_enabled = 1

let g:ale_pattern_options = {
	\ '\.min\.css$' : {
		\ 'ale_fixers'  : [],
		\ 'ale_linters' : [],
	\ },
	\ '\.min\.js$' : {
		\ 'ale_fixers'  : [],
		\ 'ale_linters' : [],
	\ },
\ }


" Filetype-specific fixers/linters

let g:ale_fixers = {
	\ '*'          : [ 'remove_trailing_lines', 'trim_whitespace' ],
	\ 'css'        : [ 'prettier', 'stylelint'                    ],
	\ 'javascript' : [ 'eslint'                                   ],
	\ 'php'        : [ 'phpmd'                                    ],
	\ 'python'     : [ 'isort', 'yapf'                            ],
	\ 'scss'       : [ 'prettier', 'stylelint'                    ],
	\ 'sh'         : [ 'shfmt'                                    ]
\ }

let g:ale_linters = {
	\ 'html'       : [ 'htmlhint', 'proselint', 'tidy'    ],
	\ 'javascript' : [ 'eslint'                           ],
	\ 'php'        : [ 'phpmd'                            ],
	\ 'scss'       : [ 'stylelint'                        ],
	\ 'vim'        : [ 'ale_custom_linting_rules', 'vint' ]
\ }


" HTML tidy options
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options    = '-q -e -language en'

" phpmd options
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,design,naming,unusedcode'

" shellcheck options
" Disable [SC1090] Can't follow non-constant source
" Disable [SC1117] Backslash is literal in "\e". Prefer explicit escaping: "\\e".
" Disable [SC2059] Don't use variables in the printf format string
let g:ale_sh_shellcheck_options = '-e SC1090 -e SC1117 -e SC2059 -s bash -x'

" pylint options
let g:ale_python_pylint_options = '-d line-too-long'


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
