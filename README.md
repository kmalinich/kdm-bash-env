# Overview
* ~2700+ lines of code/functions that _should probably be individual scripts_
  * It used to be a lot longer - but I'm getting smarter, slowly
* I originally wrote most of this for/at work
* Everything in this repo was done for the express purpose of automating or improving a process
  * Even if it was just shaving off 10ms - everything adds up in the end, and eventually you'll start going home earlier
* It got a wee bit out of control after a while

# Disclaimers
* It's the worst.
* I'm the worst.
* Don't use it.
  * (or do)

# "Tested" against
* **Frequently**
  * Arch Linux 4.9+
  * macOS 10.11+
    * Requires w/GNU coreutils+findutils installed via brew, force linked
  * RHEL/CentOS 6+
  * Raspbian jessie+
* **Infrequently**
  * Ubuntu 14.04+
* **Notes**
  * This isn't to say everything is 100% working across all platforms
  * "Tested" is in air quotes
  * I fix the broken code as/if I find it

# [Submodules](.gitmodules)
* **ViM plugins**
  * ap/vim-css-color
  * ervandew/supertab
  * fidian/hexmode
  * godlygeek/tabular
  * kmalinich/salt-jinja-vim
  * kmalinich/vim-brogrammer-theme
  * MarcWeber/vim-addon-local-vimrc
  * moon-musick/vim-logrotate
  * othree/javascript-libraries-syntax.vim
  * pangloss/vim-javascript
  * paranoida/vim-airlineish
  * saltstack/salt-vim
  * scrooloose/nerdtree
  * sheerun/vim-polyglot
  * tpope/vim-fugitive
  * vim-airline/vim-airline
  * vim-scripts/Align
  * vim-scripts/interfaces
  * w0rp/ale
  * Xuyuanp/nerdtree-git-plugin
* **Other**
  * kmalinich/snmp-mibs

# Notes
* **ViM plugins**
  * All vim plugins are loaded using native vim package management
* **True color**
  * Make sure you're using a terminal emulator that supports this
    * Enabling true color without support will make things very weird looking
  * I'm still searching for a way to do true color inside GNU screen sessions
  * [`output()`](.kdm/bashrc.d/functions-text#L5-L158) always uses 24bit color regardless of `TERM` variable or supportedness
    * I'll get to it someday
  * To enable, set `COLOR_16M=1` in `~/.kdm/bash-env.conf` and reopen terminal
  * For best results, use vim 8+/neovim 0.2.1+ (w/termguicolors support)
* **Misc**
  * Facter 4+ is required for the dynamic MOTD
    * For best performance, configure fact caching in `facter.conf`
  * There's way, _way, **way**_ too many SNMP MIBs in the `~/.snmp/mibs` submodule
    * It slows down snmp commands quite a lot
    * If you don't want/need ~500 SNMP MIBs, remove the submodule
  * Any missing binaries/libraries it (probably) should warn you about

# Install
First, back up your existing bash history (probably located at `~/.bash_history`)
```
cd
git clone https://github.com/kmalinich/kdm-bash-env.git
cd kdm-bash-env
.kdm/install
```
Then log out and back in, hopefully it doesn't break.
