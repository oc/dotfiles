" vim: filetype=vim
""
"" Misc
""
set nocompatible     " vim mode
set undofile         " persist undo tree
set history=100      " lines of command line history
set undodir=~/.vim/tmp/undo//,/tmp//    " undo files
set directory=~/.vim/tmp/swap//,/tmp//  " swap files
set autoread         " read a unchanged file if it's been changed outside vim
set ruler            " show line and column number of cursor position
set showcmd          " display incomplete commands
""
"" Color and syntax highlighting
""
set background=light

syntax on 
filetype plugin indent on        " language dependent indenting

""
"" User Interface
""
set backspace=indent,eol,start " allow backspacing over items

set incsearch                  " display search results incrementally
set hlsearch                   " highligh all search matches
set smartcase                  " ignore case on lower letter search
set gdefault                   " default substitute all changes on a line

" Disable bells
set noerrorbells
set novisualbell
set t_vb=

set wildmode=longest,list,full " shell like tab completion behavior
set wildignore+=*.pyc,*.png

autocmd InsertLeave * set nocursorline " no cursorline in normal mode
autocmd InsertEnter * set cursorline   " cursorline in insert mode
autocmd FileType help wincmd L         " Open help window in vertical split
nnoremap K <nop>                       " kill manual key

""
"" Movement
""

" We have to learn to use h, j, k, l
#nnoremap <up> <nop>
#nnoremap <down> <nop>
#nnoremap <left> <nop>
#nnoremap <right> <nop>
#inoremap <up> <nop>
#inoremap <down> <nop>
#inoremap <left> <nop>
#inoremap <right> <nop>

" Move up and down in screen lines, not file lines:
nnoremap j gj
nnoremap k gk

" Tab movement shortcuts:
nnoremap <left> gT
nnoremap <right> gt
nnoremap <silent> <up> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|else\|exe "tabm ".(tabpagenr()-2)\|endif<CR> 
nnoremap <silent> <down> :if tabpagenr() == tabpagenr("$")\|tabm 0\|else\|exe "tabm ".tabpagenr()\|endif<CR>

" Split movement shortcuts:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set scrolloff=3   " Display next/prev 3 lines after/before cursor

" Allow moving cursor past end of line in visual block mode:
set virtualedit+=block

" Keep search matches in the middle of the window:
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

""
"" Text
""
set expandtab      " expand tabs to spaces
set tabstop=2      " width of an actual tab char in spaces
set softtabstop=2  " width of an inserted tab char
set shiftwidth=2   " number of spaces for each indent
set smarttab       " inserts spaces according to shiftwidt when <TAB>

set wrap           " visually wrap lines longer than the window

set colorcolumn=80 " mark lines over 80 columns


""
"" Languages
""

" JSON syntax highlighting:
au BufNewFile,BufRead *.json setlocal ft=javascript

" Salt state syntax highlighting:
au BufNewFile,BufRead *.sls setlocal ft=yaml

" 4 spaces for Python:
au FileType python setl softtabstop=4 tabstop=4 shiftwidth=4

" Tabs for Go:
au FileType go setl noexpandtab softtabstop=0 tabstop=4 shiftwidth=4 nosmarttab


""
"" Statusbar
""
set statusline=%f%m%r%h%w\ %y\ [%{&ff}]
set statusline+=%=%-14.(%l,%c%V%)\ %L

set laststatus=2


""
"" Leader shortcuts
""
" Avoid pinky stretch for '\':
let mapleader = ","

" Toggle line numbers:
nnoremap  <leader>n :set nonumber!<CR>

" Toggle display of invisible characters (like TextMate):
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>

" Toggle paste mode for no autoindenting:
nnoremap <leader>p :set invpaste<CR>

" Opens an edit command with the path of the current file filled in
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the current file filled in
nnoremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Create vertical split and navigate to it:
nnoremap <leader>w <C-w>v<C-w>l

" Clear search highlights:
nnoremap <leader><space> :noh<CR>


""
"" Commands
""

" always jump to the last known cursor position
augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

runtime bundle.vim
