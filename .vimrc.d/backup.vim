scriptencoding utf-8


" Centralize backup and temporary storage

if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif

if !isdirectory($HOME."/.vim/backup")
	call mkdir($HOME."/.vim/backup", "", 0700)
endif

if !isdirectory($HOME."/.vim/tmp")
	call mkdir($HOME."/.vim/tmp", "", 0700)
endif

if !isdirectory($HOME."/.vim/undo")
	call mkdir($HOME."/.vim/undo", "", 0700)
endif


set backupdir=~/.vim/backup
" set directory=~/.vim/tmp
set undodir=~/.vim/undo

" Save undo data
set undofile

" Backup file file extension
set backupext=.vimbackup

" Enable backup files
" set backup

" Disable backup files
" Some servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
