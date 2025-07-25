scriptencoding utf-8


" Disable vim-polyglot loading specific types
let g:polyglot_disabled = ['csv']


" C
au Filetype c,cpp let b:comment_leader = '/* '
au Filetype c,cpp set autoindent
au Filetype c,cpp set expandtab
au Filetype c,cpp set softtabstop=2
au Filetype c,cpp set noexpandtab

" CSS
au Filetype css let b:comment_leader = '/* '
au Filetype css set noexpandtab

" HTML
au Filetype html let b:comment_leader = '<!-- '
au Filetype html set noexpandtab

" JS
au Filetype javascript let b:comment_leader = '//'
au Filetype javascript set noexpandtab

" nginx
au Filetype nginx let b:comment_leader = '#'
au Filetype nginx set noexpandtab

" PHP
au Filetype php let b:comment_leader = '//'
au Filetype php set noexpandtab

" Python
au Filetype python let b:comment_leader = '#'
au Filetype python set autoindent
au Filetype python set expandtab
au Filetype python set shiftwidth=4
au Filetype python set softtabstop=4
au Filetype python set tabstop=4
au Filetype python call DisableSpaceIndentHighlight()

" sh/bash
au Filetype sh let b:comment_leader = '#'
au Filetype sh set noexpandtab


" Crontab
au Filetype crontab let b:comment_leader = '#'
augroup ft_crontab
	au BufRead *crontab* let b:comment_leader = '#'
	au BufRead *crontab* set filetype=crontab
	au BufRead *crontab* call matchdelete(w:m3)
augroup END

" Crontab (macOS)
augroup ft_crontab_macos
	au BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup END

" Environment files (dotenv)
augroup ft_env
	au BufRead .env* set filetype=cfg
	au BufRead .env* set noexpandtab
augroup END

" Interfaces file
augroup ft_interfaces
	au BufRead /etc/network/interfaces set filetype=interfaces
augroup END

" JSON family
augroup ft_json
	au BufRead *.json set filetype=json
	au BufRead *.json set noexpandtab

	au BufRead *babelrc set filetype=json
	au BufRead *babelrc set noexpandtab

	au BufRead *csslintrc set filetype=json
	au BufRead *csslintrc set noexpandtab

	au BufRead *eslintrc set filetype=json
	au BufRead *eslintrc set noexpandtab

	au BufRead *htmlhintrc set filetype=json
	au BufRead *htmlhintrc set noexpandtab

	au BufRead *jsbeautifyrc set filetype=json
	au BufRead *jsbeautifyrc set noexpandtab

	au BufRead *jshintrc set filetype=json
	au BufRead *jshintrc set noexpandtab

	au BufRead *prettierrc set filetype=json
	au BufRead *prettierrc set noexpandtab

	au BufRead *proselintrc set filetype=json
	au BufRead *proselintrc set noexpandtab

	au BufRead *stylelintrc set filetype=json
	au BufRead *stylelintrc set noexpandtab

	au BufRead composer.lock set filetype=json
	au BufRead composer.lock set noexpandtab
augroup END

" jsonc comment highlighting support
autocmd FileType json syntax match Comment +\/\/.\+$+


" Markdown
augroup ft_markdown
	au BufRead *.md set filetype=markdown
	au BufRead *.md call matchdelete(w:m3)
augroup END

" OpenVPN
augroup ft_openvpn
	au BufRead /usr/local/etc/openvpn/*.conf set filetype=cfg
	au BufRead /opt/homebrew/etc/openvpn/*.conf set filetype=cfg
	au BufRead /etc/openvpn/*.conf set filetype=cfg
	au BufRead *.ovpn set filetype=cfg
augroup END

" Ruby
augroup ft_ruby
	au BufRead *.rb let b:comment_leader = '#'
	au BufRead *.rb set filetype=ruby
	au BufRead *.rb call matchdelete(w:m3)
augroup END

" Salt sls
augroup ft_sls
	au BufRead *.sls let b:comment_leader = '#'
	au BufRead *.sls set filetype=sls
	au BufRead *.sls call matchdelete(w:m3)
augroup END

" systemd unit files
au Filetype systemd let b:comment_leader = '#'
augroup ft_systemd
	au BufRead *.mount let b:comment_leader = '#'
	au BufRead *.mount set filetype=systemd

	au BufRead *.service let b:comment_leader = '#'
	au BufRead *.service set filetype=systemd

	au BufRead *.socket let b:comment_leader = '#'
	au BufRead *.socket set filetype=systemd

	au BufRead *.target let b:comment_leader = '#'
	au BufRead *.target set filetype=systemd

	au BufRead *.timer let b:comment_leader = '#'
	au BufRead *.timer set filetype=systemd
augroup END

" Varnish vcl
augroup ft_vcl
	au BufRead *.vcl* let b:comment_leader = '#'
	au BufRead *.vcl* set filetype=vcl
	au BufRead *.vcl* set noexpandtab

	au BufRead *.vcl.jinja let b:comment_leader = '#'
	au BufRead *.vcl.jinja set filetype=vcl
	au BufRead *.vcl.jinja set noexpandtab
augroup END

" ViM
au Filetype vim let b:comment_leader = '" '
augroup ft_vim
	au BufRead *vimrc let b:comment_leader = '" '
	au BufRead *vimrc set textwidth=0
augroup END

" VMWare vmx
augroup ft_vmx
	au BufRead *.vmx set filetype=cfg
augroup END

" XML
augroup ft_xml
	" macOS property list (plist) files
	au BufRead *.plist set filetype=xml

	" TunerPro xdf
	au BufRead *.xdf set filetype=xml
augroup END

" YAML family
augroup ft_yaml
	au BufRead *.yaml let b:comment_leader = '#'
	au BufRead *.yaml set filetype=yaml
	au BufRead *.yaml call DisableSpaceIndentHighlight()

	au BufRead *.yml let b:comment_leader = '#'
	au BufRead *.yml set filetype=yaml
	au BufRead *.yml call DisableSpaceIndentHighlight()

	au BufRead *gemrc let b:comment_leader = '#'
	au BufRead *gemrc set filetype=yaml
	au BufRead *gemrc call DisableSpaceIndentHighlight()

	au BufRead */salt*/master.d/*.conf let b:comment_leader = '#'
	au BufRead */salt*/master.d/*.conf set filetype=yaml
	au BufRead */salt*/master.d/*.conf call DisableSpaceIndentHighlight()

	au BufRead */salt*/cloud let b:comment_leader = '#'
	au BufRead */salt*/cloud set filetype=yaml
	au BufRead */salt*/cloud call DisableSpaceIndentHighlight()

	au BufRead */salt*/grains let b:comment_leader = '#'
	au BufRead */salt*/grains set filetype=yaml
	au BufRead */salt*/grains call DisableSpaceIndentHighlight()

	au BufRead */salt*/master let b:comment_leader = '#'
	au BufRead */salt*/master set filetype=yaml
	au BufRead */salt*/master call DisableSpaceIndentHighlight()

	au BufRead */salt*/minion let b:comment_leader = '#'
	au BufRead */salt*/minion set filetype=yaml
	au BufRead */salt*/minion call DisableSpaceIndentHighlight()

	au BufRead */salt*/proxy let b:comment_leader = '#'
	au BufRead */salt*/proxy set filetype=yaml
	au BufRead */salt*/proxy call DisableSpaceIndentHighlight()

	au BufRead */salt*/roster let b:comment_leader = '#'
	au BufRead */salt*/roster set filetype=yaml
	au BufRead */salt*/roster call DisableSpaceIndentHighlight()
augroup END


" vim: set filetype=vim ts=2 sw=2 tw=0 noet :
