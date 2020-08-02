call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tikhomirov/vim-glsl'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

colorscheme dracula

let g:coc_global_extensions = [ 'coc-tsserver' ]

set wildignore+=**/tmp/*,**/dist/*,**/log/*,**/node_modules/*,**/bower_components/*,**/electron-builds/*,*.so,*.swp,*.zip
set swapfile
set directory=~/.vim/tmp

set tabstop=2 shiftwidth=2 expandtab

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
set number
set nowrap

filetype plugin indent on

:command WQ wq
:command Wq wq
:command W w

highlight Normal ctermbg=None
syntax enable
