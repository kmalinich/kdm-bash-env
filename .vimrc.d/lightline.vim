scriptencoding utf-8


" Base config
set laststatus=2
set noshowmode

" lightline config
let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'active': {
	\   'left': [
	\     [ 'mode', 'paste' ],
	\     [ 'cocstatus', 'readonly', 'filename', 'modified' ]
	\   ],
	\   'right': [
	\     [ 'lineinfo' ],
	\     [ 'percent' ],
	\     [ 'fileformat', 'fileencoding', 'filetype' ],
	\     [ 'charvaluehex' ]
	\   ]
	\ },
	\ 'component': {
	\   'charvaluehex': '0x%B'
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status'
	\ }
\ }


" Use autocmd to force lightline update
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
