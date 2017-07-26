" vim:foldmethod=marker:foldlevel=0

" Vim {{{
set nocompatible
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set fileformats=unix,dos,mac
set nocp
" }}}

" Vundle {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'vim-scripts/Solarized'
" }}}

" Colors {{{
set t_Co=256
set background=dark
colorscheme solarized

syntax enable
" }}}

" Whitespace {{{
set tabstop=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set shiftround
set shiftwidth=4
set formatoptions=tcqro
set autoindent

" }}}

" UI {{{
set number
set showcmd
set wildmenu

set mouse-=a
set noerrorbells
set ruler
set scrolloff=5
" }}}

" Folding {{{
set foldenable
set foldlevelstart=0
nnoremap <space> za     " space opens/closes folds
set foldmethod=syntax
" }}}
