local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- a table to access global variables
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options-- Map leader to space

opt.termguicolors = true -- enable true color

opt.cursorline = true
opt.signcolumn = "yes"
opt.encoding = "utf-8"
opt.showmode = false

opt.wildignore:append({ "**/node_modules/*", "**/android/*", "**/ios/*", "**/.git/*" })

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.incsearch = true
opt.showcmd = true
opt.number = true
opt.hlsearch = false
opt.hidden = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.backspace = { "indent", "eol", "start" }
opt.wrap = false

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

local undodir = vim.fn.stdpath("data") .. "/.undo"
opt.undodir = undodir

opt.textwidth = 80
opt.colorcolumn = "80"

-- Autocommands
cmd("autocmd FileType gitcommit set colorcolumn+=51")
cmd("autocmd FileType gitcommit set colorcolumn=73")
cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank { timeout = 500 }")
cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif") -- Open help in a vertical split

-- Keybindings
-- Leader key
g.mapleader = " "

-- nvim-cmp
opt.completeopt = { "menu", "menuone", "noselect" }

if fn.has("mac") == 1 then
	opt.clipboard = "unnamed"
end
if fn.has("unix") == 1 then
	opt.clipboard = "unnamedplus"
end
