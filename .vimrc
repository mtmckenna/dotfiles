call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ervandew/supertab'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/zenburn'
call plug#end()

colorscheme zenburn

set wildignore+=*/tmp/*,*/dist/*,*/log/*,*/node_modules/*,*/bower_components/*,*/electron-builds/*,*.so,*.swp,*.zip

" no left scrollbar
set guioptions-=L

" don't syntax highlight after 250 chars--it's a performance thing
set synmaxcol=250

" two character spaces for tabs
set tabstop=2 shiftwidth=2 expandtab

" Can copy/paste across vim buffers
set clipboard+=unnamed

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Turn on line numbers
set number

" Highlight current line
set cursorline

" Capital w saves the file
command WQ wq
command Wq wq
command W w

" Don't wrap lines
set nowrap

" Set swapfile directory
set swapfile
set directory=~/.vim/tmp

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
