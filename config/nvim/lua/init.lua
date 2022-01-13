local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup({
  function(use)
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'airblade/vim-gitgutter'
    use 'christoomey/vim-tmux-navigator'
    use 'junegunn/fzf.vim'
    use 'mbbill/undotree'
    use 'rafamadriz/friendly-snippets'
    use 'svermeulen/vim-easyclip'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'nvim-lualine/lualine.nvim'
    use 'vim-test/vim-test'
    
    -- Themes
    use 'navarasu/onedark.nvim'
    use 'morhetz/gruvbox'
    use 'voldikss/vim-floaterm'

    if packer_bootstrap then
      require('packer').sync()
    end
  end
})

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
map("n", "<space>", "<nop>", { silent = true })

local has = function(x)
  return vim.fn.has(x) == 1
end

-- Settings
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.incsearch = true
vim.o.showcmd = true
vim.o.number = true
vim.o.hlsearch = false
vim.o.hidden = true
vim.o.ruler = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.encoding = "utf-8"

vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true

vim.o.undodir = '.undo/, ~/.vim/.undo/, /tmp//'
 
vim.o.textwidth = 80
vim.o.colorcolumn = 80

vim.o.signcolumn = 'yes'

-- TODO: this is not working
-- if has('macunix') then
--   vim.o.clipboard = 'unnamed'
-- end
-- if has('unix') then
--   vim.o.clipboard = 'unnamedplus'
-- end

-- Mappings
map('i', 'jk', '<ESC>', { silent = true })

-- Store relative jumps in the jump list
-- TODO: this is not working properly
map('n', '<expr> k', [[ (v:count > 1 ? "m'" . v:count : '') . 'k' ]])
map('n', '<expr> j', [[ (v:count > 1 ? "m'" . v:count : '') . 'j' ]])

map('n', '<leader>sv', ':source $MYVIMRC<cr>', { silent = true })
map('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', { silent = true })

map('n', '<leader>ff', ':GFiles<cr>', { silent = true })
map('n', '<leader>fb', ':Buffers<cr>', { silent = true })
map('n', '<leader>fbc', ':BCommits<cr>', { silent = true })
map('n', '<leader>fm', ':Marks<cr>', { silent = true })
map('n', '<leader>fc', ':Commits<cr>', { silent = true })
map('n', '<leader>fp', ':Maps<cr>', { silent = true })

map('n', '``', ':FloatermToggle<cr>', { silent = true })
map('t', '``', '<C-\\><C-n>:FloatermToggle<cr>', { silent = true })

map('n', '<leader>z', ':UndotreeToggle<cr>', { silent = true })

map('n', '<leader>gb', ':Git blame<CR>', { silent = true })
map('n', '<leader>gd', ':Gvdiffsplit<CR>', { silent = true })
map('n', '<leader>gs', ':Git<CR>', { silent = true })
map('n', '<leader>gf', ':GF?<CR>', { silent = true })
map('n', '<leader>gc', ':Git commit<CR>', { silent = true })
map('n', '<leader>gh', ':0Gclog<CR>', { silent = true })
map('n', '<leader>ge', ':Gedit<CR>', { silent = true })
map('n', '<leader>gdh', ':diffget //2', { silent = true })
map('n', '<leader>gdl', ':diffget //3', { silent = true })

map('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

-- Plugin settings
vim.g.undotree_SetFocusWhenToggle = 1

vim.g.EasyClipAutoFormat = 1
vim.g.EasyClipUseSubstituteDefaults = 1

require('lualine').setup { options = { theme = 'onedark' } }

require('nvim-treesitter.configs').setup {
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
