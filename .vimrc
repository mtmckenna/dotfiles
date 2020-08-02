"fzf  nerdcommenter  syntastic  tsuquyomi  vim-glsl  vim-prettier

set wildignore+=**/tmp/*,**/dist/*,**/log/*,**/node_modules/*,**/bower_components/*,**/electron-builds/*,*.so,*.swp,*.zi
set rtp +=/usr/bin
set rtp +=~/.fzf
set rtp +=~/.vim/pack/plugins/start/syntastic/syntax_checkers
set swapfile
set directory=~/.vim/tmp

set tabstop=2 shiftwidth=2 expandtab

let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_disable_quickfix = 1

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
set number
set nowrap

filetype plugin indent on

:command WQ wq
:command Wq wq
:command W w

highlight Normal ctermbg=None


let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:syntastic_glsl_checkers = ['cgc']
let g:syntastic_css_checkers = ['csslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

packadd! dracula
syntax enable
colorscheme dracula
