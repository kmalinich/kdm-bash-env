scriptencoding utf-8


" Disable startup warning - I know when nvim/vim is outdated anyway, and sometimes I've got places to be
let g:coc_disable_startup_warning = 1


" let g:coc_force_debug = 1

" Better display for messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience
set updatetime=200

" Don't pass messages to |ins-completion-menu|
set shortmess+=c


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif


" Ctrl-j/Ctrl-k : Navigate diagnostics
nmap <silent> <C-j> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-k> <Plug>(coc-diagnostic-next)

" Ctrl-f : Apply AutoFix to all problems
nmap <silent> <C-f> <Plug>(coc-fix)

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f <Plug>(coc-format-selected)
" nmap <leader>f <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a <Plug>(coc-codeaction-selected)
" nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use K to show documentation in preview window
" function! s:show_documentation()
" 	if (index(['vim','help'], &filetype) >= 0)
" 		execute 'h '.expand('<cword>')
" 	else
" 		call CocAction('doHover')
" 	endif
" endfunction
" nnoremap <silent> K :call <SID>show_documentation()<CR>


" Create mappings for function text object, requires document symbols feature of languageserver
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Using CocList

" Spacebar-a : Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>

" Spacebar-e : Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>

" Spacebar-c : Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>


" Spacebar-o : Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>

" Spacebar-s : Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>


" Spacebar-j : Do default action for next item
nnoremap <silent> <space>j :<C-u>CocNext<CR>

" Spacebar-k : Do default action for previous item
nnoremap <silent> <space>k :<C-u>CocPrev<CR>

" Spacebar-p : Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>



" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Global extensions (auto-install)
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-eslint',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-markdownlint',
	\ 'coc-python',
	\ 'coc-stylelintplus',
	\ 'coc-svg',
	\ 'coc-tsserver',
	\ 'coc-yaml'
\ ]
" \ 'coc-highlight',
" \ 'coc-clangd',
" \ 'coc-omnisharp',
" \ 'coc-powershell',
" \ 'coc-xml',


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
