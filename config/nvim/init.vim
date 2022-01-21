" ==============================================================================
" Plugins
" ==============================================================================
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'machakann/vim-highlightedyank'

  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'glepnir/dashboard-nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'

  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'neovim/nvim-lspconfig'

  " TODO: install and setup ALE
  " TODO: setup luasnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'airblade/vim-gitgutter'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mbbill/undotree'
  Plug 'prettier/vim-prettier', { 
    \'do': 'yarn install --frozen-lockfile --production' 
  \}
  Plug 'rafamadriz/friendly-snippets'
  Plug 'svermeulen/vim-easyclip'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'vim-test/vim-test'
  Plug 'windwp/nvim-autopairs'

  " Themes
  Plug 'navarasu/onedark.nvim'
  Plug 'morhetz/gruvbox'
  Plug 'voldikss/vim-floaterm'
  Plug 'simrat39/symbols-outline.nvim'
call plug#end()

lua require('plugins')

" ==============================================================================
" Vim settings
" ==============================================================================
set cursorline
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
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
set signcolumn=yes

syntax on

set encoding=utf-8
set noshowmode

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

" Git Gutter needs this set lower so that it can refresh more often
set updatetime=100

" Limit git commit title to 51 characters
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set colorcolumn=73

" Set the leader key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

set timeoutlen=500

set background=dark 


" ==============================================================================
" Custom keybindings
" ==============================================================================
" Exit insert mode with jk
inoremap jk <Esc>

nnoremap <C-s> :w<CR>

cnoremap <expr> <C-j> ("\<C-n>")
cnoremap <expr> <C-k> ("\<C-p>")

inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Edit vimrc
nnoremap <silent><leader>ev :vsplit $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Better indentation
vnoremap \< <gv
vnoremap \> >gv

" Use alt + nav keys to resize windows
nnoremap <M-j> :resize -5<CR>
nnoremap <M-k> :resize +5<CR>
nnoremap <M-h> :vertical resize -5<CR>
nnoremap <M-l> :vertical resize +5<CR>

" Quickfix lists
nnoremap <silent> <leader>cc :cclose<CR>
nnoremap <silent> <leader>co :copen<CR>

" harpoon
nnoremap <silent> <leader>ha :lua require("harpoon.mark").add_file()<CR>:echo 'Added harpoon mark'<CR>
nnoremap <silent> <leader>' :lua require("harpoon.ui").toggle_quick_menu()<CR> 

" nvim-cmp
set completeopt=menu,menuone,noselect
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
  
nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ac :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>d :lua vim.diagnostic.open_float()<CR>

" Go to defintion in new vertical split
nmap <leader>gdw <C-w>v:lua vim.lsp.buf.definition()<CR>

nnoremap <silent> <C-i> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>

" Vim test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" nvim-tree
nnoremap <silent><leader>` :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Store relative line number jumps in the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Select characters in current line, excluding leading and trailing whitespace
nnoremap <leader>V ^v$h

" fzf
" nnoremap <silent><leader>ff :GFiles<cr>
" nnoremap <silent><leader>fbr :Buffers<cr>
" nnoremap <silent><leader>flb :BCommits<cr>
" nnoremap <silent><leader>fbl :BLines<cr>
" nnoremap <silent><leader>flr :Commits<cr>
" nnoremap <silent><leader>f: :History:<cr>
" nnoremap <silent><leader>f/ :History/<cr>
" nnoremap <silent><leader>fm :Marks<cr>
" nnoremap <silent><leader>fp :Maps<cr>

nnoremap <leader>ss :Ag<Space>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>ft <cmd>Telescope live_grep<cr>
nnoremap <leader>fbs <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fws <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>f: <cmd>Telescope command_history<cr>
nnoremap <leader>fib <cmd>Telescope current_buffer_fuzzy_find<cr>

nnoremap <leader>fbr <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fpc <cmd>Telescope git_commits<cr>
nnoremap <leader>fbc <cmd>Telescope git_bcommits<cr>

nnoremap <leader>fts <cmd>Telescope treesitter<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fkm <cmd>Telescope keymaps<cr>

" Copy the current filepath to the unnamed register
nnoremap <leader>cfp :let @*=expand("%")<cr>:echo "current filepath copied to clipboard"<cr>

" Toogle Floaterm
nnoremap <silent>`` :FloatermToggle<cr>
tnoremap <silent>`` <C-\><C-n>:FloatermToggle<cr>

" Undotree
nnoremap <silent><leader>z :UndotreeToggle<cr>

" Trigger silver searcher

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

" Search for highlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Prettier
nnoremap <silent> <leader>p :PrettierAsync<CR>

" dashboard-nvim
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

nnoremap <silent> <leader>o :SymbolsOutline<CR>

" ==============================================================================
" Plugin settings
" ==============================================================================
" EasyClip
let g:EasyClipAutoFormat = 1
let g:EasyClipUseSubstituteDefaults = 1

" Undotree
let g:undotree_SetFocusWhenToggle = 1
" dashboard-nvim
let g:dashboard_default_executive = 'telescope'

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 500

let g:dashboard_custom_header = [
  \'    _   __            _    __ _          ',
  \'   / | / /___   ____ | |  / /(_)____ ___ ',
  \'  /  |/ // _ \ / __ \| | / // // __ `__ \',
  \' / /|  //  __// /_/ /| |/ // // / / / / /',
  \'/_/ |_/ \___/ \____/ |___//_//_/ /_/ /_/ ',
  \]

let g:prettier#autoformat_config_present = 1
