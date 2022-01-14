" Plugins
  " Install vim-plug if not found
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif

  call plug#begin('~/.vim/plugged')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'ThePrimeagen/harpoon'

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'neovim/nvim-lspconfig'

    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'airblade/vim-gitgutter'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mbbill/undotree'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
    Plug 'rafamadriz/friendly-snippets'
    Plug 'svermeulen/vim-easyclip'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'vim-test/vim-test'

    " Themes
    Plug 'navarasu/onedark.nvim'
    Plug 'morhetz/gruvbox'
    Plug 'voldikss/vim-floaterm'
  call plug#end()

  lua require('plugins')

" Vim settings
  set cursorline
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
  set autoindent
  set incsearch
  set showcmd
  set number
  set nohlsearch
  set hidden
  set ruler
  set number
  set relativenumber
  set backspace=indent,eol,start
  set nowrap

  set wildignore+=**/node_modules/*
  set wildignore+=**/android/*
  set wildignore+=**/ios/*
  set wildignore+=**/.git/*

  syntax on

  " Set the clipboard to be able to copy text into the system clipbord
  if has('macunix')
    set clipboard=unnamed
  endif
  if has('unix')
    set clipboard=unnamedplus
  endif

  " Save backup, undo and swap files in folders in the home directory
  set nobackup
  set noswapfile
  set undodir=.undo/,~/.vim/.undo/,/tmp//"
  set undofile

  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Force the cursor onto a new line after 80 characters
  set textwidth=80
  set colorcolumn=80
  " Colour the 81st (or 73rd) column so that we don’t type over our limit
  set colorcolumn=+1

  " Limit git commit title to 51 characters
  autocmd FileType gitcommit set colorcolumn+=51
  autocmd FileType gitcommit set colorcolumn=73

  " Set the leader key
  nnoremap <SPACE> <Nop>
  let mapleader = " "

  " Exit insert mode with jk
  inoremap jk <Esc>

  " Edit vimrc
  nnoremap <silent><leader>ev :vsplit $MYVIMRC<cr>

  " Source vimrc
  nnoremap <leader>sv :source $MYVIMRC<cr>

" Quickfix lists
  nnoremap <silent> <leader>cc :cclose<CR>
  nnoremap <silent> <leader>co :copen<CR>

" harpoon
  nnoremap <silent> <leader>ha :lua require("harpoon.mark").add_file()<CR> :echo 'Added harpoon mark'<CR>
  nnoremap <silent> <leader>' :lua require("harpoon.ui").toggle_quick_menu()<CR> 

" nvm-cmp
  set completeopt=menu,menuone,noselect
  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
    
  nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> <leader>ac <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <silent> <leader>o <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.open_float()<CR>

  " Go to defintion in new vertical split
  nmap <leader>gdw <C-w>v<cmd>lua vim.lsp.buf.definition()<CR>

  nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Vim test
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

  " Store relative line number jumps in the jumplist.
  nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
  nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

  " Select characters in current line, excluding leading and trailing whitespace
  nnoremap <leader>V ^v$h

" Custom keybindings
  " Normal mode
    " fzf
    nnoremap <silent><leader>ff :GFiles<cr>
    nnoremap <silent><leader>fb :Buffers<cr>
    nnoremap <silent><leader>flb :BCommits<cr>
    nnoremap <silent><leader>fm :Marks<cr>
    nnoremap <silent><leader>flp :Commits<cr>
    nnoremap <silent><leader>fp :Maps<cr>

    " Copy the current filepath to the unnamed register
    nnoremap <leader>cfp :let @*=expand("%")<cr>:echo "current filepath copied to clipboard"<cr>

    " Toogle Floaterm
    nnoremap <silent>`` :FloatermToggle<cr>
    tnoremap <silent>`` <C-\><C-n>:FloatermToggle<cr>

    " Undotree
    let g:undotree_SetFocusWhenToggle = 1
    nnoremap <silent><leader>z :UndotreeToggle<cr>

    " Tab commands
    nnoremap th :tabfirst<CR>
    nnoremap tj :tabnext<CR>
    nnoremap tk :tabprev<CR>
    nnoremap tl :tablast<CR>
    nnoremap tt :tabedit<Space>
    nnoremap tn :tabnext<Space>
    nnoremap tm :tabm<Space>
    nnoremap td :tabclose<CR>

    " Trigger silver searcher
    nnoremap <leader>ss :Ag<Space>

    " Need to remap set marker binding as a workaround for vim-unimpaired
    nnoremap gm m

    " Git commands from fugitive
    nnoremap <silent> <leader>gb :Git blame<CR>
    nnoremap <silent> <leader>gd :Gvdiffsplit<CR>
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>gf :GF?<CR>
    nnoremap <silent> <leader>gc :Git commit<CR>
    nnoremap <silent> <leader>gh :0Gclog<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gdh :diffget //2<CR>
    nnoremap <silent> <leader>gdl :diffget //3<CR>

  " Visual mode
    " Search for highlighted text
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Git Gutter
  set updatetime=100

" EasyClip
  let g:EasyClipAutoFormat = 1
  let g:EasyClipUseSubstituteDefaults = 1

" nvim-tree
  nnoremap <silent><leader>` :NvimTreeToggle<CR>
  nnoremap <leader>r :NvimTreeRefresh<CR>
  nnoremap <leader>n :NvimTreeFindFile<CR>

