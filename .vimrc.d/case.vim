" http://vim.wikia.com/wiki/Capitalize_words_and_regions_easily

" gcw        - Capitalize word (from cursor position to end of word)
" gcW        - Capitalize WORD (from cursor position to end of WORD)
" gciw       - Capitalize inner word (from start to end)
" gciW       - Capitalize inner WORD (from start to end)
" gcis       - Capitalize inner sentence
" gc$        - Capitalize until end of line (from cursor postition)
" gcgc       - Capitalize whole line (from start to end)
" gcc        - Capitalize whole line
" {Visual}gc - Capitalize highlighted text

if (&tildeop)
	nmap gcw guw~l
	nmap gcW guW~l

	nmap gciw guiw~l
	nmap gciW guiW~l

	nmap gcis guis~l
	nmap gc$  gu$~l

	nmap gcgc guu~l
	nmap gcc  guu~l
	vmap gc   gu~l
else
	nmap gcw guw~h
	nmap gcW guW~h

	nmap gciw guiw~h
	nmap gciW guiW~h

	nmap gcis guis~h
	nmap gc$  gu$~h

	nmap gcgc guu~h
	nmap gcc guu~h
	vmap gc gu~h
endif

" Ctrl-c : toggle word case
inoremap <C-c> <Esc>g~iwea
nnoremap <C-c> <Esc>g~iwea<Esc>
