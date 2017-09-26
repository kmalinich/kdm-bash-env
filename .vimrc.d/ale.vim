scriptencoding utf-8

" ale (Asynchronous Lint Engine) base config
" Set default lint delay to 500ms
let g:ale_lint_delay = 500
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
