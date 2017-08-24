call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ervandew/supertab'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
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
