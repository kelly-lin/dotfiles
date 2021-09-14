" Vundle - must be at the top of the file 
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-surround'
Plugin 'svermeulen/vim-easyclip'
Plugin 'tpope/vim-repeat'

" All plugins must be declared before the statements below
call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0

" Undotree
nnoremap <F5> :UndotreeToggle<CR>

" Scrooloose/Syntastic 
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" General config
syntax on

" Key remaps
nnoremap gm m

" Change the cursor style for normal/insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Set tab sizes
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set ai

set incsearch
set showcmd
set number
set hlsearch
set ruler
set number relativenumber

set backspace=indent,eol,start

colorscheme atom-dark
let g:airline_theme='minimalist'
highlight Comment ctermfg=green
highlight ColorColumn ctermbg=235

" Force the cursor onto a new line after 80 characters
set textwidth=80
set colorcolumn=80
" Colour the 81st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1

" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72

" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set colorcolumn=73
