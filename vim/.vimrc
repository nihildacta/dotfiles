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
set wrap
set scrolloff=10
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set number
set list listchars=tab:\ \ ,trail:·
set wildmenu
set timeout timeoutlen=1000 ttimeoutlen=100
set laststatus=2
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)
set guioptions-=T
set encoding=utf8
set autoread
set shell=/bin/bash
set path+=**
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set notagrelative

set backupdir=~/tmp
set dir=~/tmp

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

let g:ctrlp_show_hidden=1
let g:ctrlp_working_path_mode=0
let g:ctrlp_max_height=30
let g:scala_sort_across_groups=1

:nnoremap § :nohlsearch<cr>


call plug#begin('~/.vim/plugged')
" plugins goes here

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'joonty/vdebug'
Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim'

call plug#end()
filetype plugin indent on
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :retab
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell spelllang=en_us


augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/'
        \ && !isdirectory(expand("%:h"))
        \ | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1)
        \ | redraw! | endif
augroup END

colorscheme gruvbox
set diffopt+=vertical
set background=dark

if strftime("%H") < 18 && strftime("%H") > 7
  set background=light
endif

if &diff
    syntax off
    set diffopt+=iwhite
endif

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=237
endif

set viminfo='100,n$HOME/.vim/files/info/viminfo
set tags=./.git/tags;/
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=PSR1,PSR2'

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_options["break_on_open"] = 0
let g:vdebug_features = { 'max_children': 128 }
let g:airline_powerline_fonts = 1

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
let EnErrorStyle = 'EnError'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

map <C-n> :NERDTreeToggle<CR>
map <C-p> :CtrlP<CR>
map <C-j> <Esc>:tabprev<CR>
map <C-k> <Esc>:tabnext<CR>
map <C-t> <Esc>:tabnew<CR>
map <F8> :TagbarToggle<CR>
map <F12> :!ctags -R --exclude=target --exclude=vendor -f ./.git/tags . <CR>
nnoremap <Leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

if filereadable("./.lnvimrc")
    execute "source ./.lnvimrc"
endif
