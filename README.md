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
  * macOS 11.1+
    * Requires w/GNU coreutils+findutils installed via brew, force linked
  * RHEL/CentOS 8+
  * Raspbian buster+
* **Notes**
  * This isn't to say everything is 100% working across all platforms
  * "Tested" is in air quotes
  * I fix the broken code as/if I find it

# [Submodules](.gitmodules)

* **neovim plugins**
  * ap/vim-css-color
  * ciaranm/securemodelines
  * ervandew/supertab
  * fidian/hexmode
  * itchyny/lightline.vim
  * kmalinich/Align
  * kmalinich/salt-jinja-vim
  * kmalinich/vim-brogrammer-theme
  * moon-musick/vim-logrotate
  * neoclide/coc.nvim
  * othree/javascript-libraries-syntax.vim
  * pangloss/vim-javascript
  * saltstack/salt-vim
  * sheerun/vim-polyglot
  * tangledhelix/vim-kickstart
  * tpope/vim-fugitive
  * vim-scripts/interfaces
  * zimbatm/haproxy.vim

# Notes

* **neovim plugins**
  * All vim plugins are loaded using native vim package management
* **True color**
  * Make sure you're using a terminal emulator that supports this
    * Using true color without support will make things very weird looking
  * GNU screen sessions (as of right now) require a very, very recent version
  * [`output()`](.kdm/rc.d/text#L5-L191) always uses 24bit color regardless of `TERM` variable or supportedness
    * I'll get to it someday
  * For best results, use vim 8+/neovim 0.5.0+ (w/termguicolors support)
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
