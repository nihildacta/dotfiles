syntax on

set nocompatible
set backup
set writebackup
set noswapfile
set history=100
set ruler
set showcmd
set incsearch
set hlsearch
set smartcase
set hidden
set nofoldenable
set nowrap
set scrolloff=10
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set number
set list listchars=tab:\ \ ,trail:·

set timeout timeoutlen=1000 ttimeoutlen=100
set laststatus=2
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)
set guioptions-=T
set encoding=utf-8
set autoread
set shell=/usr/bin/bash

set backupdir=~/tmp
set dir=~/tmp

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

let g:ctrlp_show_hidden=1
let g:ctrlp_working_path_mode=0
let g:ctrlp_max_height=30
let $PYTHONPATH='/usr/lib/python3.5/site-packages'
let $BROWSER='firefox'

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/.vagrant/*,*/target/*,*/.ensime_cache/*

:nnoremap § :nohlsearch<cr>


call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'kien/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'derekwyatt/vim-scala', { 'for' : 'scala' }
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'w0ng/vim-hybrid'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'lervag/vimtex'
Plug 'ensime/ensime-vim'

call plug#end()

filetype plugin indent on
autocmd BufWritePre * :%s/\s\+$//e

" :colorscheme gruvbox
:colorscheme hybrid

set background=dark

if &diff
    syntax off
    set diffopt+=iwhite
endif

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=237
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
let g:syntastic_scala_checkers = ['scalac']
let g:syntastic_php_phpcs_args = "--standard=PSR1,PSR2"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline_powerline_fonts = 1

let EnErrorStyle='EnError'


map <C-n> :NERDTreeToggle<CR>
map <C-p> :CtrlP<CR>
map <C-t> :TagbarToggle<CR>
map <C-k> <Esc>:tabprev<CR>
map <C-j> <Esc>:tabnext<CR>
map <C-t> <Esc>:tabnew<CR>
map <C-q> <Esc>:q<CR>

