scriptencoding utf-8


" Based on https://github.com/Konfekt/local-viminfo

if exists('g:loaded_shada_local')
	finish
endif


" From https://www.reddit.com/r/vim/comments/povbkh/tip_viminfo_per_project/
" Default to global shada if no local shada found
" Start with global shada if local shada is empty
" Respect &viminfofile if set explicitly, in particular by -i command-line flag, by setting viminfo file path in &viminfo instead of &viminfofile

let s:global_shadafile = stdpath('state') .. '/shada/main.shada'

" call nvim_notify('updating &shada variable with global shadafile ' .. s:global_shadafile, 3, { 'title': 'shada-local', 'timeout': 2000 })
let &shada .= (empty(&shada) ? '' : ',') .. 'n' .. s:global_shadafile


" Make sessions respect local shada
" Since view session files do not set v:this_session and keep the global current working directory, we skip those for reloading shada
let v:this_session = ''
let s:last_session = ''

augroup viminfo
	autocmd!
	autocmd SessionLoadPost *
		\ if v:this_session !=# s:last_session |
		\   let s:last_session = v:this_session | call s:VimInfoSessionLoad() |
		\ endif

	if has('##SessionWritePost')
		autocmd SessionWritePost * wshada
	endif
augroup END


let s:last_local_shadafile = ''
let s:local_shadafile = ''


function! s:VimInfoSessionLoad()
	let s:local_shadafile = findfile('.shada', getcwd(-1) .. ';')

	if empty(s:local_shadafile)
		" call nvim_notify('local shadafile ' .. s:local_shadafile .. ' empty', 3, { 'title': 'shada-local', 'timeout': 2000 })
		return
	endif

	let s:local_shadafile = fnamemodify(s:local_shadafile, ':p')

	if getfsize(s:local_shadafile) == 0 && exists('*filecopy')
		" call_nvim_notify('deleting local shadafile', 3, { 'title': 'shada-local', 'timeout': 2000 })
		call delete(s:local_shadafile)
		" call_nvim_notify('copying global shadafile ' .. s:global_shadafile .. ' to local shadafile ' .. s:local_shadafile, 3, { 'title': 'shada-local', 'timeout': 2000 })
		call filecopy(s:global_shadafile, s:local_shadafile)
	endif

	if s:local_shadafile !=# s:last_local_shadafile
		let s:last_local_shadafile = s:local_shadafile

		" call_nvim_notify('updating &shada variable with local shadafile', 3, { 'title': 'shada-local', 'timeout': 2000 })
		let &shada = substitute(&shada, '\%(^\|,\)n\zs.*$', escape(s:local_shadafile, '\'), '')
		rshada
	endif
endfunction


call s:VimInfoSessionLoad()

let g:loaded_shada_local = 1



" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
