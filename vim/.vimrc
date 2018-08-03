" vim:foldmethod=marker:foldlevel=0

" Vim {{{
set nocompatible
set shell=/bin/sh
set fileformats=unix,dos,mac
" }}}

" Vundle {{{
if !filereadable($HOME . '/.vim/bundle/Vundle.vim/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
    exec '!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim'
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/Solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on
"}}}

" Plugin config {{{
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1

set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline\ Nerd\ Font\ Complete\:h18
let g:airline_powerline_fonts = 1
let NERDTreeIgnore = ['\.o$', '\.pyc$']
" }}}

" Colors {{{
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" }}}

" Default encoding {{{
set encoding=utf8 nobomb
set fileencoding=utf8
" }}}

" UI {{{
syntax on
"set cursorline
set number ruler
set modeline
set laststatus=2
set showcmd
set wildmenu

set mouse=a     " lets try the mouse
set noerrorbells
set scrolloff=5
" }}}

" Line-wrap and tabs {{{
set wrap
set linebreak
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4
set formatoptions=tcqro
set autoindent
set copyindent
set showmatch

" }}}

" Search {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab
  " }}}

" Folding {{{
set nofoldenable
set foldlevelstart=0
nnoremap <space> za     " space opens/closes folds
set foldmethod=syntax
" }}}

" Vim stuff
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set wildmenu
set clipboard=unnamed

" }}}
"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
