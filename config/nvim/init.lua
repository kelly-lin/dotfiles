local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options-- Map leader to space

require('plugins')

require('config.completion')
require('config.lsp')
require('config.tree-sitter')
require('config.auto-pairs')
require('config.harpoon')
require('config.nvim-tree')
require('config.symbols-outline')
require('config.telescope')

require('theme')

--
-- Globals
g.EasyClipAutoFormat = 1
g.EasyClipUseSubstituteDefaults = 1

-- Undotree
g.undotree_SetFocusWhenToggle = 1

-- Dashboard-nvim
g.dashboard_default_executive = 'telescope'

-- vim-highlightedyank
g.highlightedyank_highlight_duration = 500

g.dashboard_custom_header = {
  [[    _   __            _    __ _          ]],
  [[   / | / /___   ____ | |  / /(_)____ ___ ]],
  [[  /  |/ // _ \ / __ \| | / // // __ `__ \]],
  [[ / /|  //  __// /_/ /| |/ // // / / / / /]],
  [[/_/ |_/ \___/ \____/ |___//_//_/ /_/ /_/ ]],
}

cmd [[let g:prettier#autoformat_config_present = 1]]

-- Vim options
opt.cursorline = true
opt.signcolumn = 'yes'
opt.encoding = 'utf-8'
opt.showmode = false

opt.wildignore:append { '**/node_modules/*', '**/android/*', '**/ios/*', '**/.git/*' }

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.smartindent = true
opt.autoindent = true
opt.incsearch = true
opt.showcmd = true
opt.number = true
opt.hlsearch = false
opt.hidden = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.backspace = { 'indent', 'eol', 'start' }
opt.wrap = false

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

local undodir = vim.fn.stdpath('data')..'/.undo'
opt.undodir = undodir

opt.textwidth = 80
opt.colorcolumn = '80'

-- do i need this?
-- opt.colorcolumn = opt.colorcolumn + 1
opt.updatetime = 100

-- Autocommands
cmd 'autocmd FileType gitcommit set colorcolumn+=51'
cmd 'autocmd FileType gitcommit set colorcolumn=73'

-- Keybindings
-- Leader key
g.mapleader = ' '

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jk', '<ESC>') -- exit insert mode

cmd [[inoremap <expr> <C-j> ("\<C-n>")]]
cmd [[inoremap <expr> <C-k> ("\<C-p>")]]

cmd [[cnoremap <expr> <C-j> ("\<C-n>")]]
cmd [[cnoremap <expr> <C-k> ("\<C-p>")]]

cmd [[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']]
cmd [[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']]

-- Edit and source vimrc
map('n', '<leader>ev', ':vsplit $MYVIMRC<CR>', { silent = true })
map('n', '<leader>sv', ':source $MYVIMRC<CR>')

-- Need to remap set marker binding as a workaround for vim-unimpaired
map('n', 'gm', 'm')

map('n', '<C-s>', ':w<CR>')

map('n', '<M-j>', ':resize -5<CR>')
map('n', '<M-k>', ':resize +5<CR>')
map('n', '<M-h>', ':vertical resize -5<CR>')
map('n', '<M-l>', ':vertical resize +5<CR>')

map('n', '<leader>cfp', ':let @*=expand("%")<cr>:echo "current filepath copied to clipboard"<cr>')

-- Better indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Quickfix lists
map('n', '<leader>cc', ':cclose<CR>')
map('n', '<leader>co', ':copen<CR>')

-- Harpoon
map('n', '<leader>ha', [[:lua require("harpoon.mark").add_file()<CR>:echo 'Added harpoon mark'<CR>]])
map('n', '<leader>ha', [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]])

-- nvim-cmp
opt.completeopt = { 'menu', 'menuone', 'noselect' }

map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { silent = true })
map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { silent = true })
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { silent = true })
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { silent = true })
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { silent = true })

map('n', '<C-i>', ':lua vim.lsp.buf.signature_help()<CR>', { silent = true })
map('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { silent = true })
map('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>', { silent = true })

-- Go to defintion in new vertical split
map('n', '<leader>gdw <C-w>v:lua', 'vim.lsp.buf.definition()<CR>', { silent = true })

-- nvim-tree
map('n', '<leader>`', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')

map('n', '<leader>ss', ':Ag<space>')

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>ft', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fbs', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', '<leader>fws', '<cmd>Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>f:', '<cmd>Telescope command_history<CR>')
map('n', '<leader>fib', '<cmd>Telescope current_buffer_fuzzy_find<CR>')

map('n', '<leader>fbr', '<cmd>Telescope git_branches<CR>')
map('n', '<leader>fgs', '<cmd>Telescope git_status<CR>')
map('n', '<leader>fpc', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>fbc', '<cmd>Telescope git_bcommits<CR>')

map('n', '<leader>fts', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>')
map('n', '<leader>fkm', '<cmd>Telescope keymaps<CR>')

-- Undotree
map('n', '<leader>z', ':UndotreeToggle<CR>')

-- Git fugitive
map('n', '<leader>gb', ':Git blame<CR>', { silent = true })
map('n', '<leader>gd', ':Gvdiffsplit<CR>', { silent = true })
map('n', '<leader>gs', ':Git<CR>', { silent = true })
map('n', '<leader>gf', ':GF?<CR>', { silent = true })
map('n', '<leader>gc', ':Git commit<CR>', { silent = true })
map('n', '<leader>gh', ':0Gclog<CR>', { silent = true })
map('n', '<leader>ge', ':Gedit<CR>', { silent = true })
map('n', '<leader>gdh', ':diffget //2<CR>', { silent = true })
map('n', '<leader>gdl', ':diffget //3<CR>', { silent = true })

-- Search for highlighted text
map('v', '//', [[y/V<C-R>=escape(@",'/')<CR><CR>]])

-- Prettier
map('n', '<leader>p', ':PrettierAsync<CR>')

-- Dashboard
map('n', '<leader>ss', ':<C-u>SessionSave<CR>')
map('n', '<leader>sl', ':<C-u>SessionLoad<CR>')

-- Symbols outline
map('n', '<leader>o', ':SymbolsOutline<CR>')

-- Floaterm
map('n', '``', ':FloatermToggle<CR>')
map('n', '``', [[<C-\><C-n>:FloatermToggle<cr>]])

if (fn.has('macunix')) then
  opt.clipboard = 'unnamed'
end
if (fn.has('unix')) then
  opt.clipboard = 'unnamedplus'
end
