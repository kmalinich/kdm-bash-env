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

  * bash 4+
  * Arch Linux 5.5+
  * macOS 10.15+
    * Requires w/GNU coreutils+findutils installed via brew, force linked
  * RHEL/CentOS 7+
  * Raspbian buster+
* **Notes**
  * This isn't to say everything is 100% working across all platforms
  * "Tested" is in air quotes
  * I fix the broken code as/if I find it

# [Submodules](.gitmodules)

* **neovim plugins**
  * ap/vim-css-color
  * ciaranm/securemodelines
  * fidian/hexmode
  * kmalinich/salt-jinja-vim
  * kmalinich/vim-brogrammer-theme
  * MarcWeber/vim-addon-local-vimrc
  * moon-musick/vim-logrotate
  * neoclide/coc.nvim
  * othree/javascript-libraries-syntax.vim
  * pangloss/vim-javascript
  * paranoida/vim-airlineish
  * RRethy/vim-illuminate
  * saltstack/salt-vim
  * sheerun/vim-polyglot
  * tangledhelix/vim-kickstart
  * tpope/vim-fugitive
  * vim-airline/vim-airline
  * vim-scripts/Align
  * vim-scripts/interfaces
  * w0rp/ale
  * zimbatm/haproxy.vim

# Notes

* **neovim plugins**
  * All vim plugins are loaded using native vim package management
* **True color**
  * Make sure you're using a terminal emulator that supports this
    * Enabling true color without support will make things very weird looking
  * I'm still searching for a way to do true color inside GNU screen sessions
  * [`output()`](.kdm/rc.d/text#L5-L191) always uses 24bit color regardless of `TERM` variable or supportedness
    * I'll get to it someday
  * To enable, set `COLOR_16M=1` in `~/.kdm/bash-env.conf` and reopen terminal
  * For best results, use vim 8+/neovim 0.2.1+ (w/termguicolors support)
* **Misc**
  * Facter 4+ is required for the dynamic MOTD
    * For best performance, configure fact caching in `facter.conf`
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
