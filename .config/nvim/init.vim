" Plugins
  " Install vim-plug if not found
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
      silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

  " Plugins
    call plug#begin('~/.vim/plugged')
      Plug 'alvan/vim-closetag'
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
      Plug 'airblade/vim-gitgutter'
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
      Plug 'mbbill/undotree'
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
      Plug 'rafamadriz/friendly-snippets'
      Plug 'svermeulen/vim-easyclip'
      Plug 'tpope/vim-unimpaired'
      Plug 'tpope/vim-commentary'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-repeat'
      Plug 'tpope/vim-surround'
      Plug 'nvim-lualine/lualine.nvim'
      Plug 'mkitt/tabline.vim'

      " Themes
      Plug 'navarasu/onedark.nvim'
      Plug 'morhetz/gruvbox'
      Plug 'voldikss/vim-floaterm'
    call plug#end()

" Vim settings
  set cursorline
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
  set ai
  set incsearch
  set showcmd
  set number
  set nohlsearch
  set hidden
  set ruler
  set number relativenumber
  set backspace=indent,eol,start
  set nowrap

  set wildignore+=**/node_modules/*
  set wildignore+=**/android/*
  set wildignore+=**/ios/*
  set wildignore+=**/.git/*

  syntax on

  " Set the clipbord to be able to copy text into the system clipbord
  set clipboard=unnamed

  " Save backup, undo and swap files in folders in the home directory
  set nobackup
  set noswapfile
  set undodir=.undo/,~/.vim/.undo/,/tmp//"
  set undofile

  " Set the leader key
  nnoremap <SPACE> <Nop>
  let mapleader = " "

  " Store relative line number jumps in the jumplist.
  nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
  nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Theme
  let g:onedark_style = 'darker'
  colorscheme onedark

" Character limits
  " Force the cursor onto a new line after 80 characters
  set textwidth=80
  set colorcolumn=80
  " Colour the 81st (or 73rd) column so that we don’t type over our limit
  set colorcolumn=+1

  " Limit git commit title to 51 characters
  autocmd FileType gitcommit set colorcolumn+=51
  autocmd FileType gitcommit set colorcolumn=73

" Custom keybindings
  " Normal mode
    " Quit without saving using QQ
    nnoremap QQ ZQ

    " Open fzf files
    nnoremap <silent><C-p> :GFiles<cr>

    " Copy the current filepath to the unnamed register
    nnoremap <leader>cfp :let @*=expand("%")<cr>:echo "current filepath copied to clipboard"<cr>
    " Toogle Floaterm
    nnoremap <silent>`` :FloatermToggle<cr>
    tnoremap <silent>`` <C-\><C-n>:FloatermToggle<cr>

    " Undotree
    let g:undotree_SetFocusWhenToggle = 1
    nnoremap <silent><leader>z :UndotreeToggle<cr>

    " Open coc explorer
    nnoremap <silent><leader>` :CocCommand explorer<cr>

    " Edit vimrc
    nnoremap <silent><leader>ev :vsplit $MYVIMRC<cr>
    " Source vimrc
    nnoremap <leader>sv :source $MYVIMRC<cr>

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
    nnoremap <silent> <leader>gs :below Git<CR>
    nnoremap <silent> <leader>gf :GF?<CR>
    nnoremap <silent> <leader>gc :below Git commit<CR>

  " Insert mode
    inoremap jk <Esc>

  " Visual mode
    " Search for highlighted text
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Git Gutter"
  " This fixes a bug where the symbols would not set the colors properly
  set updatetime=250
  let g:gitgutter_max_signs = 500
  " No mapping
  let g:gitgutter_map_keys = 0
  " Colors
  let g:gitgutter_override_sign_column_highlight = 0
  highlight clear SignColumn
  highlight GitGutterAdd ctermfg=2
  highlight GitGutterChange ctermfg=3
  highlight GitGutterDelete ctermfg=1
  highlight GitGutterChangeDelete ctermfg=4

" EasyClip
  let g:EasyClipAutoFormat=1
  let g:EasyClipUseSubstituteDefaults=1

" Treesitter 
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  textobjects = {
    enable = true,
  },
}
EOF

" Lualine
lua <<EOF
require('lualine').setup {
  options = {
    theme = 'onedark'
  }
}
EOF

" Change the cursor for different modes Cursor settings: 1 -> blinking block 2 -> solid block 3 -> blinking underscore 4 -> solid underscore 5 -> blinking vertical bar 6 -> solid vertical bar let &t_SI.="\e[5 q" "SI = INSERT mode let &t_SR.="\e[4 q" "SR = REPLACE mode let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE) Reset the cursor on start (for older versions of vim, usually not required) augroup mycmds au!  autocmd vimenter * silent !echo -ne "\e[2 q" augroup end Override the terminal colors so that it is more readable highlight Visual ctermfg=Black ctermbg=Grey Enable autocompletion: set wildmode=longest,list,full Automatically deletes all trailing whitespace and newlines at end of file on save autocmd BufWritePre * %s/\s\+$//e autocmd BufWritePre * %s/\n\+\%$//e autocmd BufWritePre *.[ch] %s/\%$/\r/e coc config Set internal encoding of vim, not needed on neovim, since coc.nvim using some
  " unicode characters in the file autoload/float.vim
  set encoding=utf-8

  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  set signcolumn=yes
  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  " if has("nvim-0.5.0") || has("patch-8.1.1564")
  "   " Recently vim can merge signcolumn and number column into one
  "   set signcolumn=number
  " else
  "   set signcolumn=yes
  " endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <plug>(coc-classobj-i)
  xmap ac <plug>(coc-classobj-a)
  omap ac <plug>(coc-classobj-a)

  " remap <c-f> and <c-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
    nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
    inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
    inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<left>"
    vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
    vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
  endif

  " use ctrl-s for selections ranges.
  " requires 'textdocument/selectionrange' support of language server.
  nmap <silent> <c-s> <plug>(coc-range-select)
  xmap <silent> <c-s> <plug>(coc-range-select)

  " add (neo)vim's native statusline support.
  " note: please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " mappings for coclist
  " show all diagnostics.
  nnoremap <silent><nowait> <leader>d :CocList diagnostics<cr>
  " manage extensions.
  " nnoremap <silent><nowait> <space>ex  :<c-u>coclist extensions<cr>
  " show commands.
  " nnoremap <silent><nowait> <space>c  :<c-u>coclist commands<cr>
  " find symbol of current document.
  nnoremap <silent><nowait> <leader>o  :<c-u>CocList outline<cr>
  " search workspace symbols.
  " nnoremap <silent><nowait> <space>l  :<c-u>coclist -i symbols<cr>
  " do default action for next item.
  " nnoremap <silent><nowait> <space>j  :<c-u>cocnext<cr>
  " do default action for previous item.

  " declare coc extensions
  let g:coc_global_extensions = [
    \'coc-markdownlint',
    \'coc-yank',
    \'coc-tsserver',
    \'coc-svg',
    \'coc-sh',
    \'coc-stylelint',
    \'coc-ltex',
    \'coc-html-css-support',
    \'coc-eslint',
    \'coc-highlight',
    \'coc-vetur',
    \'coc-go',
    \'coc-python',
    \'coc-explorer',
    \'coc-flutter',
    \'coc-json',
    \'coc-git',
    \'coc-solargraph',
    \'coc-emmet',
    \'coc-prettier',
    \'coc-vetur',
    \'coc-pairs'
  \]
