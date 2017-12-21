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
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/Solarized'
" }}}

let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

set encoding=utf8
set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline\ Nerd\ Font\ Complete\:h18
let g:airline_powerline_fonts = 1
let NERDTreeIgnore = ['\.o$', '\.pyc$']

" Colors {{{
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
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

set mouse=a     " lets try the mouse
set noerrorbells
set ruler
set scrolloff=5
" }}}

" Search {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab
  " }}}

" Folding {{{
set foldenable
set foldlevelstart=0
nnoremap <space> za     " space opens/closes folds
set foldmethod=syntax
" }}}

" Python checker {{{
":command Sd SyntasticToggleMode
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }
noremap <C-w>e :SyntasticCheck<CR>
noremap <C-w>f :SyntasticToggleMode<CR>

"silent! nmap <F6> :SyntasticToggleMode<CR>
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
" }}}
