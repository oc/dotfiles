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
set number           " Show line numbers by default
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

if has("gui_running")
  set background=dark
else
  set background=light
  let g:solarized_termcolors=256
endif

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
set wildignore+=*.o,*.pyc,*.png,*.obj,.git,*.rbc,*.class,*/tmp/*,*.so,*.swp,*.zip

autocmd FileType help wincmd L         " Open help window in vertical split

""
"" Keys and Leader shortcuts
""
let mapleader = ","

nnoremap <leader>n :set nonumber!<CR>          " toggle line numbers
nnoremap <leader>m :set norelativenumber!<CR>  " toggle relative numbering
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

"" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" :w!! alias
cmap w!! %!sudo tee > /dev/null %

" format the entire file
nmap <leader>fef ggVG=

" Find git conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

""
"" Text
""
if has("gui_running")
  set guifont=Monaco:h16
  set guioptions=egmt
endif

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

" Clojure
let vimclojure#NailgunClient = "/usr/local/bin/ng"
let g:paredit_mode           = 1
let g:clj_highlight_builtins = 1
let g:clj_highlight_contrib  = 1
let g:clj_paren_rainbow      = 1
let clj_paren_rainbow        = 1
let clj_highlight_builtins   = 1
let clj_highlight_contrib    = 1
let vimclojure#ParenRainbow  = 1
let vimclojure#WantNailgun   = 1
let vimclojure#NailgunClient = "/usr/local/bin/ng"
au BufRead,BufNewFile {*.clj,*.cljs} setl ft=clojure sw=2 ts=2

""
"" Statusbar
""

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  set statusline=%f%m%r%h%w\ %y\ [%{&ff}]
  set statusline+=%=%-14.(%l,%c%V%)\ %L\ %b\ 0x%B
endif

" always jump to the last known cursor position
augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

"" Neat stuff taken from janus

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i
 
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif
