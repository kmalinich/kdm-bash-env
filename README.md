# kdm-bash-env
My bash environment.
Use bash 4+ and true color terminal for best results.
Actually, for best results, don't use this at all.

## Overview
My .bashrc has ~2700+ lines of code/functions that should probably be individual scripts, and it used to be a lot longer.
I slowly wrote this over 3 years at work, then stripped it of company-specific code/info and put it on GitHub.

Everything in this repo was done for the express purpose of automating or improving a process, even if it was just shaving off 100ms. Everything adds up in the end.

I update it almost every day.

It got a wee bit out of control after a while, as it started a dumb challenge to write portable code.

## Occasionally used with:
* Arch Linux 4.9+
* macOS 10.11+ (w/GNU coreutils+findutils installed)
* RHEL/CentOS 6+
* Raspbian jessie+
* Ubuntu 14.04+

(that's not to say everything is 100% working across all platforms - I fix the broken code as I find it)

## Submodules
All listed are GitHub repos.

### ViM plugins
* ap/vim-css-color
* ervandew/supertab
* fidian/hexmode
* godlygeek/tabular
* kmalinich/salt-jinja-vim
* marciomazza/vim-brogrammer-theme
* moon-musick/vim-logrotate
* pangloss/vim-javascript
* paranoida/vim-airlineish
* saltstack/salt-vim
* scrooloose/nerdtree
* tpope/vim-fugitive
* vim-airline/vim-airline
* vim-scripts/align
* vim-scripts/interfaces
* w0rp/ale
* xuyuanp/nerdtree-git-plugin

All vim plugins are loaded using native vim package management.

### Other
* kmalinich/snmp-mibs

## True color notes
* Use a terminal emulator that supports this, obviously
* Set `COLOR_16M=1` in `~/.kdm/bash-env.conf` to enable for ls dircolors and vim
* Use vim 8+/neovim 0.2.1+ w/termguicolors support for best results

## Other misc notes
* Facter 4+ is required for the dynamic MOTD
* There's way, way, way too many SNMP MIBs in ~/.snmp/mibs - it slows down snmp commands quite a lot
* Any other missing binaries/libraries it (probably) should warn you about

## Install

```
cd ${HOME}
git clone https://github.com/kmalinich/kdm-bash-env.git
cd kdm-bash-env
.kdm/install
cd ${HOME}
```

Then log out and back in, hopefully it doesn't break.

## Disclaimer
It's the worst.
I'm the worst.
Don't use it.
(or do)
