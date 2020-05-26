scriptencoding utf-8


" Extend vim-illuminate delay
let g:Illuminate_delay = 500

" Highlight word under cursor
let g:Illuminate_highlightUnderCursor = 1


" Only highlight specific groups
let g:Illuminate_ftHighlightGroups = {
	\ 'javascript' : [
		\ 'jsClassDefinition',
		\ 'jsClassFuncName',
		\ 'jsFuncBlock',
		\ 'jsFuncCall',
		\ 'jsParen',
		\ 'jsParenIfElse',
		\ 'jsVariableDef'
	\ ]
\ }


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
