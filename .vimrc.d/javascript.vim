scriptencoding utf-8

" Don't make JSX files require a .jsx extension
let g:jsx_ext_required = 0

" JavaScript plugin config
" Sisnable syntax highlighting for JSDoc + NGDoc
let g:javascript_plugin_jsdoc = 0
let g:javascript_plugin_ngdoc = 0

" Code conceal/folding configuration
let g:javascript_conceal_NaN                       = 'ℕ'
let g:javascript_conceal_arrow_function            = '⇒'
let g:javascript_conceal_function                  = 'ƒ'
let g:javascript_conceal_null                      = 'ø'
let g:javascript_conceal_prototype                 = '¶'
let g:javascript_conceal_return                    = '⇚'
let g:javascript_conceal_static                    = '•'
let g:javascript_conceal_super                     = 'Ω'
let g:javascript_conceal_this                      = '@'
let g:javascript_conceal_undefined                 = '¿'

let g:javascript_conceal_noarg_arrow_function      = '⇒'
let g:javascript_conceal_underscore_arrow_function = '⇒'


" javascript-libraries-syntax config
let g:used_javascript_libs = 'jquery,react,d3'
