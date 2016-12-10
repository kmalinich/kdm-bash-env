# kdm-bash-env
My BASH environment. Warning: Bash 4+ and 24bit TERM support required.

My .bashrc has ~2200+ lines of functions that should probably be individual scripts, and it used to be a lot longer.
I slowly wrote this over 3 years at work, then stripped it of company-specific code/info and put it on GitHub.

Everything in this repo was done for the express purpose of automating or improving a process, even if it was just shaving off 100ms. Everything adds up in the end.

I update it almost every day.

It got a wee bit out of control after a while, as it started a dumb challenge to write portable code.
I test against:
* macOS 10.11+10.12 (w/GNU coreutils+findutils installed)
* RHEL+CentOS
* Ubuntu
* Raspbian (Raspberry Pi Debian distro)

(that's not to say everything is 100% working across all platforms - I fix the broken code as I find it)

ViM plugins:
* gmarik/Vundle.vim
* WolfgangMehner/bash-support
* amadeus/vim-evokai
* ap/vim-css-color
* ervandew/supertab
* fidian/hexmode
* godlygeek/tabular
* marciomazza/vim-brogrammer-theme
* nvie/vim-flake8
* othree/html5.vim
* pangloss/vim-javascript
* puppetlabs/puppet-syntax-vim
* scrooloose/syntastic
* shawncplus/phpcomplete.vim
* tpope/vim-fugitive
* vim-airline/vim-airline
* vim-airline/vim-airline-themes
* vim-perl/vim-perl
* vim-scripts/Align
* vim-scripts/indentpython.vim
* vim-scripts/timestamp.vim

ViM 8+ w/termguicolor support required, for best experience.
Facter is required for the dynamic MOTD.
Any other missing binaries/libraries it (probably) should warn you about.
