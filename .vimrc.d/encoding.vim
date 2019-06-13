" UTF-16 fix
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif

" Use UTF8 encoding
	set       encoding=utf-8
	setglobal fileencoding=utf-8
	set       fileencodings=ucs-bom,utf-8,latin1
endif
