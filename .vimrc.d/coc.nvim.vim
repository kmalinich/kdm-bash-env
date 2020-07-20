scriptencoding utf-8


let g:coc_force_debug = 1

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000
set updatetime=300

" don't give |ins-completion-menu| messages
set shortmess+=c

" always show signcolumns
" set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction


" Use Ctrl-space to trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"


" Ctrl-j/Ctrl-k : Navigate diagnostics
" nmap <silent> <C-j> <Plug>(coc-diagnostic-prev)
" nmap <silent> <C-k> <Plug>(coc-diagnostic-next)
nmap <C-j> <Plug>(coc-diagnostic-prev)
nmap <C-k> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)



" Use K to show documentation in preview window
" function! s:show_documentation()
" 	if (index(['vim','help'], &filetype) >= 0)
" 		execute 'h '.expand('<cword>')
" 	else
" 		call CocAction('doHover')
" 	endif
" endfunction
" nnoremap <silent> K :call <SID>show_documentation()<CR>


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f <Plug>(coc-format-selected)
" nmap <leader>f <Plug>(coc-format-selected)


augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a <Plug>(coc-codeaction-selected)
" nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac <Plug>(coc-codeaction)

" Fix autofix problem of current line
" nmap <leader>qf <Plug>(coc-fix-current)


" Ctrl-f : Run fixer
nmap <C-f> <Plug>(coc-fix)


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

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" Add status line support, for integration with other plugin, checkout `:h coc-status`
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



" Global extensions (auto-install)
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-eslint',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-markdownlint',
	\ 'coc-python',
	\ 'coc-stylelintplus',
	\ 'coc-svg',
	\ 'coc-tsserver',
	\ 'coc-xml',
	\ 'coc-yaml'
\ ]
" \ 'coc-clangd',
" \ 'coc-omnisharp',
" \ 'coc-powershell',


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
