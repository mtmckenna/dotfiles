" Fallback editor. Neovim + LazyVim (see the `nvim` package) is the real setup;
" this is for quick edits, rescue shells, and boxes where installing neovim
" isn't worth it.
"
" Deliberately ZERO dependencies: no plugin manager, no node, no external
" binaries. Stock vim + this file + the vendored dracula colorscheme is
" everything. Don't add a Plug block here -- that's what the nvim package is for.

set nocompatible
filetype plugin indent on
syntax enable

" Dracula is vendored into .vim/colors (MIT, see LICENSE-dracula) so it works
" with no plugin manager and no network. Matches nvim, tmux and ghostty.
silent! colorscheme dracula
if !exists('g:colors_name')
  colorscheme habamax   " ships with vim 9.x
endif
highlight Normal ctermbg=None

set tabstop=2 shiftwidth=2 expandtab
set number
set nowrap
set incsearch hlsearch ignorecase smartcase
set backspace=indent,eol,start
set laststatus=2
set wildmenu
set wildignore+=**/tmp/*,**/dist/*,**/log/*,**/node_modules/*,**/bower_components/*,**/electron-builds/*,*.so,*.swp,*.zip

" Keep swap files out of the working tree. Created on demand so a fresh clone
" needs no mkdir step (the old vimrc errored on every file if it was missing).
let s:swapdir = expand('~/.vim/swap')
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p', 0700)
endif
set swapfile
let &directory = s:swapdir . '//'

" Typo-savers
command! W  w
command! Wq wq
command! WQ wq
command! Q  q
