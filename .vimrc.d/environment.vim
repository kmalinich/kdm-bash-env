scriptencoding utf-8


" Pull in some environment variables
let g:color_16m = $COLOR_16M

let g:domain      = $DOMAIN
let g:domain_full = $DOMAIN_FULL

let g:home = $HOME

let g:host_ip    = $HOST_IP
let g:host_short = $HOST_SHORT
let g:host_sub   = $HOST_SUB

let g:pwd           = $PWD
let g:pwd_final     = $PWD_FINAL
let g:pwd_fmt       = $PWD_FMT
let g:pwd_fmt_depth = $PWD_FMT_DEPTH

let g:term_program = $TERM_PROGRAM
let g:term_type    = $TERM

let g:uname_machine = $UNAME_MACHINE


" Shell variable
if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/usr/local/bin/bash
endif

" Configure proper make binary
let g:make = 'gmake'
if exists('make')
	let g:make = 'make'
endif


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
