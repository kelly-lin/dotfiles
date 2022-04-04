local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local should_bootsrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	should_bootsrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

cmd("packadd packer.nvim")
cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", opt = true })

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = require("config.telescope"),
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"kelly-lin/telescope-ag",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
	})

	-- LSP
	use({ "neovim/nvim-lspconfig", config = require("config.lsp") })
	use({ "nvim-lua/completion-nvim", config = require("config.completion") })
	use({ "williamboman/nvim-lsp-installer" })

	-- Completion
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })

	-- File explorer
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua", config = require("config.nvim-tree") })

	-- Dashboard
	use({ "glepnir/dashboard-nvim", config = require("config.dashboard") })

	-- Utility
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = require("config.gitsigns"),
	})
	use({ "nvim-lua/plenary.nvim" })
	use({ "ThePrimeagen/harpoon", config = require("config.harpoon") })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require("config.tree-sitter"),
	})
	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
	use({ "christoomey/vim-tmux-navigator" })
	use({ "mbbill/undotree", config = require("config.undotree") })
	use({
		"prettier/vim-prettier",
		run = "yarn install --frozen-lockfile --production",
		config = require("config.prettier"),
	})
	use({ "svermeulen/vim-easyclip", config = require("config.easyclip") })
	use({ "tpope/vim-unimpaired" })
	use({ "tpope/vim-commentary" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-surround" })
	use({ "wellle/targets.vim", requires = "tpope/vim-surround" })
	use({ "nvim-lualine/lualine.nvim", config = require("config.lualine") })
	use({ "windwp/nvim-autopairs", config = require("config.auto-pairs") })
	use({ "vim-test/vim-test" })
	use({
		"simrat39/symbols-outline.nvim",
		config = require("config.symbols-outline"),
	})
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
	use({ "ggandor/lightspeed.nvim", commit = "0b655" })

	-- Formatters
	use({ "sbdchd/neoformat" })
	use({ "ckipp01/stylua-nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = require("config.null-ls"),
	})

	-- Themes
	use({ "navarasu/onedark.nvim" })
	use({ "morhetz/gruvbox" })

	if should_bootsrap then
		require("packer").sync()
	end

	cmd("PackerInstall")
end)
