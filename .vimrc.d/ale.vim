scriptencoding utf-8

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

" \aq : Increase linting delay
nnoremap as :call ALELintSlow()<CR>

" \az : Decrease linting delay
nnoremap af :call ALELintFast()<CR>

" F8 : Fix
nmap <F8> <Plug>(ale_fix)

" Ctrl-k/Ctrl-k : Navigate ale errors
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)

" ale (Asynchronous Lint Engine) base config
" Set default lint delay to 1000ms
let g:ale_lint_delay = 1000

" Configure filetype-specific fixers
let g:ale_fixers = { 'css': [ 'prettier', 'stylelint' ], 'scss': [ 'prettier', 'stylelint' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ] }

" Configure filetype-specific linters
let g:ale_linters = { 'scss': [ 'stylelint' ], 'html': [ 'htmlhint', 'proselint', 'tidy' ], 'javascript': [ 'eslint' ], 'php': [ 'phpmd' ] }

" ale (Asynchronous Lint Engine) phpmd config
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,design,naming,unusedcode'

" ale (Asynchronous Lint Engine) shellcheck config
" Disable [SC1090] Can't follow non-constant source
" Disable [SC1091] file was not specified as input
" Disable [SC2059] Don't use variables in the printf format string
let g:ale_sh_shellcheck_options = '-e SC1090 -e SC2059 -s bash -x'

" ale (Asynchronous Lint Engine) HTML tidy config
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options    = '-q -e -language en'

" ale (Asynchronous Lint Engine) gutter config
" let g:ale_sign_column_always = 1

" ale (Asynchronous Lint Engine) symbol config
let g:ale_sign_error   = '✗'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign   guibg=#2f2f2f guifg=#e74c3c
highlight ALEWarningSign guibg=#2f2f2f guifg=#f1c40f
