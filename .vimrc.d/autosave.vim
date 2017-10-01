function! AbortIfUnchanged()
	if &modified
		let g:auto_save_abort = 0
	else
		let g:auto_save_abort = 1
	endif
endfunction

" Enable autosave on Vim startup
let g:auto_save = 1

" Autosave only on InsertLeave
let g:auto_save_events = [ 'InsertLeave' ]

" Only save if the file is changed
let g:auto_save_presave_hook = 'call AbortIfUnchanged()'
