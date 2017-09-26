" Set the terminal title to something like '[VIM] kdm-mbp.z1:~/.vimrc [+]'
let g:file_path_format = substitute(expand('%:p'), g:home, '~', '')
set titlestring=\[VIM\]\ %{host_sub}:%{file_path_format}\ %m
set title
