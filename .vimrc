" vim: filetype=vim
""
"" Misc
""
set nocompatible     " vim mode
set encoding=utf-8   " utf8 default
set noequalalways    " don't resize windows after close...

set undofile         " persist undo tree
set history=100      " lines of command line history
set undodir=~/.vim/tmp/undo//,/tmp//    " undo files
set directory=~/.vim/tmp/swap//,/tmp//  " swap files
set autoread         " read a unchanged file if it's been changed outside vim
set ruler            " show line and column number of cursor position
set showcmd          " display incomplete commands
set hidden           " Allw hidden buffers

""
"" Pathogen
"" 
call pathogen#infect()
filetype plugin indent on         " must be after pathogen#infect()

""
"" Color and syntax highlighting
""
syntax on 

set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Automatically close syntastic error window when no errors are detected:
let g:syntastic_auto_loc_list=2

" Mark syntastic errors:
let g:syntastic_enable_signs=1

""
"" User Interface
""
autocmd InsertLeave * set nocursorline " no cursorline in normal mode
autocmd InsertEnter * set cursorline   " cursorline in insert mode

set backspace=indent,eol,start " intuitive backspacing over items
set incsearch                  " display search results incrementally
set hlsearch                   " highligh all search matches
set smartcase                  " ignore case on lower letter search
set gdefault                   " default substitute all changes on a line

" Disable bells
set noerrorbells
set novisualbell
set t_vb=

" Disable dumb prompts
set shortmess=atI

set wildmode=list:longest,list:full " shell like tab completion behavior
set wildignore+=*.o,*.pyc,*.png,*.obj,.git,*.rbc,*.class

autocmd FileType help wincmd L         " Open help window in vertical split

""
"" Keys and Leader shortcuts
""
let mapleader = ","

nnoremap  <leader>n :set nonumber!<CR> " toggle line numbers
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>      " toggle showing ws-characters
nnoremap <leader>p :set invpaste<CR>   " toggle indenting paste

" Opens an edit command with the path of the current file filled in
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the current file filled in
nnoremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Create vertical split and navigate to it:
nnoremap <leader>w <C-w>v<C-w>l

" Clear search highlights:
nnoremap <leader><space> :noh<CR>

" Toggle NERDTree with leader-o
nnoremap <leader>o :NERDTreeToggle<CR>
nnoremap <leader>O :NERDTreeFind<CR>

let g:CommandTMaxHeight=20
nnoremap <leader>T :CommandTFlush<CR>

" Move up and down in screen lines, not file lines:
nnoremap j gj
nnoremap k gk

" Split movement shortcuts:
nnoremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set scrolloff=3   " Display next/prev 3 lines after/before cursor

" Allow moving cursor past end of line in visual block mode:
set virtualedit+=block

" Keep search matches in the middle of the window:
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Indent/outdent in visual mode.
nnoremap <Tab> >gv
nnoremap <S-Tab> <gv

""
"" Text
""
set guifont=Monaco:h16
set expandtab      " expand tabs to spaces
set tabstop=2      " width of an actual tab char in spaces
set softtabstop=2  " width of an inserted tab char
set shiftwidth=2   " number of spaces for each indent
set smarttab       " inserts spaces according to shiftwidt when <TAB>

set wrap           " visually wrap lines longer than the window

set colorcolumn=120 " mark lines over 120 columns


""
"" Languages
""
" Ruby
au BufRead,BufNewFile {*.pp,Rakefile,Gemfile,Vagrantfile,Thorfile,config.ru} setl ft=ruby sw=2 ts=2

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

" always jump to the last known cursor position
augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


