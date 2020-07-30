set wildignore+=**/tmp/*,**/dist/*,**/log/*,**/node_modules/*,**/bower_components/*,**/electron-builds/*,*.so,*.swp,*.zi
set rtp+=/usr/bin
set swapfile
set directory=~/.vim/tmp

set tabstop=2 shiftwidth=2 expandtab

let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_disable_quickfix = 1

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
set rtp +=~/.fzf
set number
set nowrap

filetype plugin indent on

:command WQ wq
:command Wq wq
:command W w
