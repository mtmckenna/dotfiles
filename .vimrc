set wildignore+=**/tmp/*,**/dist/*,**/log/*,**/node_modules/*,**/bower_components/*,**/electron-builds/*,*.so,*.swp,*.zip

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/zenburn'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'elmcast/elm-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'tikhomirov/vim-glsl'
call plug#end()

colorscheme zenburn

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

inoremap jj <Esc>

" Set case insensitive search
set ic

" Turn on line numbers
set number

" Highlight current line
" Note: turns out, cursorline is slow.
"set cursorline

" Capital w saves the file
command WQ wq
command Wq wq
command W w

" Don't wrap lines
set nowrap

" Set swapfile directory
set swapfile
set directory=~/.vim/tmp

" User Silver Searcher instead of Ack in Ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" Remove netwr banner
let g:netrw_banner = 0

" Don't require jsx
let g:jsx_ext_required = 0

" YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
