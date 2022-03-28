local cmd = vim.cmd
local nmap = require("utils.keymaps").nmap
local imap = require("utils.keymaps").imap
local xmap = require("utils.keymaps").xmap
local vmap = require("utils.keymaps").vmap
local tmap = require("utils.keymaps").tmap

imap("jk", "<ESC>") -- exit insert mode

nmap("Q", "<NOP>") -- disable ex-mode binding

cmd([[inoremap <expr> <C-j> ("\<C-n>")]])
cmd([[inoremap <expr> <C-k> ("\<C-p>")]])

cmd([[cnoremap <expr> <C-j> ("\<C-n>")]])
cmd([[cnoremap <expr> <C-k> ("\<C-p>")]])

-- Store relative jumps in the jump list
cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']])
cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']])

-- Reload all buffers
nmap("<leader>rbs", ":bufdo e")

-- Edit and source vimrc
nmap("<leader>ev", [[:lua require('telescope.builtin').find_files({ cwd = "~/.config/nvim/"})<CR>]], { silent = true })
nmap("<leader>sv", ":source $MYVIMRC<CR>")

-- Need to remap set marker binding as a workaround for vim-unimpaired
nmap("gm", "m")

nmap("<leader>E", "<cmd>lua vim.diagnostic.open_float()<CR>")
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

nmap("<C-s>", ":w<CR>")

nmap("<leader>FQ", ":qa!<CR>")
vmap("<C-r>", ":s/\\%V")

nmap("<M-j>", ":resize -5<CR>")
nmap("<M-k>", ":resize +5<CR>")
nmap("<M-h>", ":vertical resize -5<CR>")
nmap("<M-l>", ":vertical resize +5<CR>")

nmap("<leader>cfp", ':let @*=expand("%")<cr>:echo "current filepath copied to clipboard"<cr>')

-- Better indentation
vmap("<", "<gv")
vmap(">", ">gv")

-- Quickfix lists
nmap("<leader>cc", ":cclose<CR>")
nmap("<leader>co", ":copen<CR>")

-- Harpoon
nmap("<leader>ha", [[:lua require("harpoon.mark").add_file()<CR>:echo 'Added harpoon mark'<CR>]])
nmap([[<leader>']], [[:Telescope harpoon marks<CR>]])

-- Go to defintion in new vertical split
nmap("<leader>gdw <C-w>v:lua", "vim.lsp.buf.definition()<CR>", { silent = true })

-- nvim-tree
nmap("<leader>ef", ":NvimTreeToggle<CR>", { silent = true })

nmap("<leader>ag", ":Ag<space>")

-- Telescope
nmap("<leader>ff", "<cmd>Telescope find_files<CR>")
nmap("<leader>ft", "<cmd>Telescope live_grep<CR>")
nmap("<leader>fbs", "<cmd>Telescope buffers<CR>")
nmap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nmap("<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>")
nmap("<leader>fws", "<cmd>Telescope lsp_workspace_symbols<CR>")
nmap("<leader>f:", "<cmd>Telescope command_history<CR>")
nmap("<leader>fib", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

nmap("<leader>fbr", "<cmd>Telescope git_branches<CR>")
nmap("<leader>fgs", "<cmd>Telescope git_status<CR>")
nmap("<leader>fpc", "<cmd>Telescope git_commits<CR>")
nmap("<leader>fbc", "<cmd>Telescope git_bcommits<CR>")

-- nmap('<leader>fts', '<cmd>Telescope treesitter<CR>')
nmap("<leader>fr", "<cmd>Telescope lsp_references<CR>")
nmap("<leader>fkm", "<cmd>Telescope keymaps<CR>")

nmap(
	"<leader>fv",
	":lua require('telescope.builtin').find_files( { cwd = vim.fn.stdpath('config') })<CR>",
	{ silent = true }
)

-- Undotree
nmap("<leader>z", ":UndotreeToggle<CR>", { silent = true })

-- Git fugitive
nmap("<leader>gb", ":Git blame<CR>", { silent = true })
nmap("<leader>gds", ":Gvdiffsplit<CR>", { silent = true })
nmap("<leader>gs", ":Git<CR>", { silent = true })
nmap("<leader>gf", ":GF?<CR>", { silent = true })
nmap("<leader>gc", ":Git commit<CR>", { silent = true })
nmap("<leader>gh", ":0Gclog<CR>", { silent = true })
nmap("<leader>ge", ":Gedit<CR>", { silent = true })
nmap("<leader>gm", ":Gdiffsplit!<CR>", { silent = true })
nmap("<leader>gdh", ":diffget //2<CR>", { silent = true })
nmap("<leader>gdl", ":diffget //3<CR>", { silent = true })

-- Easyclip: we are remapping to 'gs' from 's' because of a mapping clash with
-- lightspeed
nmap("gs", "<plug>SubstituteOverMotionMap", { silent = true, noremap = false })
nmap("gss", "<plug>SubstituteLine", { noremap = false })
xmap("gs", "<plug>XEasyClipPaste", { noremap = false })

-- Search for highlighted text
vmap("//", [[y/V<C-R>=escape(@",'/')<CR><CR>]])

-- Dashboard
nmap("<leader>ss", ":<C-u>SessionSave<CR>")
nmap("<leader>sl", ":<C-u>SessionLoad<CR>")

-- Symbols outline
nmap("<leader>o", ":SymbolsOutline<CR>", { silent = true })
