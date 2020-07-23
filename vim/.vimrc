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
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'peterhoeg/vim-qml'
Plugin 'vimwiki/vimwiki'
Plugin 'vivien/vim-linux-coding-style'
Plugin 'kergoth/vim-bitbake'
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

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

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
set shiftwidth=2
set tabstop=2
set softtabstop=2
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

let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:ale_fixers = ['clang-format']
let g:ale_linters = {'cpp': ['ccls', 'clang', 'clangd', 'clangtidy', 'cppcheck', 'cpplint', 'cquery', 'flawfinder'], 'c': ['clangtidy']}
"let g:ale_c_gcc_options="-I/home/jbj/devel/ambu/base-yocto/src/amp/src/util/include"
"let g:ale_c_clang_options="-I/home/jbj/devel/ambu/base-yocto/src/amp/src/util/include"
"let g:ale_cpp_gcc_options="-I/home/jbj/devel/ambu/base-yocto/src/amp/src/util/include"
"let g:ale_cpp_clang_options="-I/home/jbj/devel/ambu/base-yocto/src/amp/src/util/include"
"let g:ale_cpp_clangtidy_options ='-I/home/jbj/devel/hawkbit-proxy/include'
"let g:ale_cpp_gcc_options ='-Isrc/hal/include -Isrc/util/include/ -std=c++17'
"let g:ale_cpp_clang_options ='-Isrc/hal/include -Isrc/util/include/ -std=c++17'
let g:ale_c_clangtidy_options ='-I/usr/lib/modules/5.5.2-arch1-1/build/include/'
"let g:ale_cpp_clangcheck_options ='--extra-arg=-Isrc/hal/include --extra-arg=-Isrc/util/include/ --extra-arg=-std=c++17'
"let g:ale_cpp_clang_options = '-std=c++14 -isystem /usr/include/c++/v1 -I/usr/include/c++/v1 -I/opt/ros/kinetic/include -I/usr/local/include -I/usr/include -I/usr/include/x86_64-linux-gnu'
"let g:ale_cpp_clangcheck_options ='-- -I/home/jbj/devel/ambu/base-yocto/src/amp/src/util/include'
" Make sure rainbow parenthesis are always active for extra festivities
"
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set list

au BufEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
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
"let g:ale_c_clang_options = '-std=c11 -Wall -I/usr/src/linux-5.0.2.arch1/include/ -I/usr/src/linux-5.0.2.arch1/arch/x86/include/'
fun! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " %"
endfun
map <leader>b :call GitCommand("blame") <CR>


highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
