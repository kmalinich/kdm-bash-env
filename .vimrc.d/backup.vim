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


" Save undo info
set undodir=~/.vim/undo
set undofile

set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Save backup
set backupext=.vimbackup
set backup
