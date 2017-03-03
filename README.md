# kdm-bash-env
My BASH environment. Warning: Bash 4+ and 24bit TERM support required.

My .bashrc has ~2200+ lines of functions that should probably be individual scripts, and it used to be a lot longer.
I slowly wrote this over 3 years at work, then stripped it of company-specific code/info and put it on GitHub.

Everything in this repo was done for the express purpose of automating or improving a process, even if it was just shaving off 100ms. Everything adds up in the end.

I update it almost every day.

It got a wee bit out of control after a while, as it started a dumb challenge to write portable code.
I use/test against:
* Arch Linux 4.9
* macOS 10.11+10.12 (w/GNU coreutils+findutils installed)
* RHEL+CentOS
* Raspbian (Raspberry Pi Debian distro)
* Ubuntu (occasionally)

(that's not to say everything is 100% working across all platforms - I fix the broken code as I find it)

ViM plugins (managed by Vundle):
* amadeus/vim-evokai
* ap/vim-css-color
* ervandew/supertab
* fidian/hexmode
* godlygeek/tabular
* kmalinich/salt-jinja-vim 
* marciomazza/vim-brogrammer-theme
* nvie/vim-flake8
* othree/html5.vim
* pangloss/vim-javascript
* puppetlabs/puppet-syntax-vim
* saltstack/salt-vim
* scrooloose/syntastic
* shawncplus/phpcomplete.vim
* stephpy/vim-yaml
* tpope/vim-fugitive
* vim-airline/vim-airline
* vim-airline/vim-airline-themes
* vim-perl/vim-perl
* vim-scripts/Align
* vim-scripts/indentpython.vim
* vim-scripts/nginx.vim
* vim-scripts/timestamp.vim

Other misc notes:
* ViM 8+ w/termguicolor support required, for best experience
* Facter is required for the dynamic MOTD (currently using 4.0.0)
* There's way, way, way too many SNMP MIBs in ~/.snmp/mibs - it slows down snmp commands
* Any other missing binaries/libraries it (probably) should warn you about

To install:

```
cd ${HOME}
git clone https://github.com/kmalinich/kdm-bash-env.git
cd kdm-bash-env
.kdm/install
cd ${HOME}
```

Then log out and back in, hopefully it doesn't break.

I know, I know, it's awful. lol
