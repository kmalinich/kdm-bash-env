scriptencoding utf-8

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
