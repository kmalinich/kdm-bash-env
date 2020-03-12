" Extend vim-illuminate delay
let g:Illuminate_delay = 0

" Highlight word under cursor
let g:Illuminate_highlightUnderCursor = 1


" Determine the highlight-group of a symbol under your cursor:
" :echo synIDattr(synID(line("."), col("."), 1), 'name'

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
