local cmd = vim.cmd
local nmap = require("utils.keymaps").nmap
local imap = require("utils.keymaps").imap
local vmap = require("utils.keymaps").vmap

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

-- Go to defintion in new vertical split
nmap("<leader>gdw <C-w>v:lua", "vim.lsp.buf.definition()<CR>", { silent = true })

-- Git fugitive
nmap("<leader>gb", ":Git blame<CR>", { silent = true })
nmap("<leader>gds", ":Gvdiffsplit<CR>", { silent = true })
nmap("<leader>gs", ":Git<CR>", { silent = true })
nmap("<leader>gf", ":GF?<CR>", { silent = true })
nmap("<leader>gc", ":Git commit<CR>", { silent = true })
nmap("<leader>gh", ":vsplit | 0Gclog<CR>", { silent = true })
nmap("<leader>ge", ":Gedit<CR>", { silent = true })
nmap("<leader>gm", ":Gdiffsplit!<CR>", { silent = true })
nmap("<leader>gdh", ":diffget //2<CR>", { silent = true })
nmap("<leader>gdl", ":diffget //3<CR>", { silent = true })

-- Search for highlighted text
vmap("//", [[y/V<C-R>=escape(@",'/')<CR><CR>]])

-- Debugging
nmap("<leader>dp", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
nmap("<leader>dn", ":lua require'dap'.continue()<CR>", { silent = true })
nmap("<leader>do", ":lua require'dap'.step_over()<CR>", { silent = true })
nmap("<leader>di", ":lua require'dap'.step_into()<CR>", { silent = true })
nmap("<leader>dk", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true })
nmap("<leader>du", ":lua require('dapui').toggle()<CR>", { silent = true })
