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
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "kelly-lin/telescope-ag", requires = { { "nvim-telescope/telescope.nvim" } } })

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use({ "nvim-lua/completion-nvim" })
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
  use({ "kyazdani42/nvim-tree.lua" })

  -- Dashboard
  use({ "glepnir/dashboard-nvim" })

  -- Debugger
  use({ "mfussenegger/nvim-dap" })
  use({ "mfussenegger/nvim-dap-python" })
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  -- Utility
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "kdheepak/lazygit.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "ThePrimeagen/harpoon" })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  use({ "christoomey/vim-tmux-navigator" })
  use({ "mbbill/undotree" })
  use({ "prettier/vim-prettier", run = "yarn install --frozen-lockfile --production" })
  use({ "svermeulen/vim-easyclip" })
  use({ "tpope/vim-unimpaired" })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-surround" })
  use({ "wellle/targets.vim" }) -- we have to source this AFTER surround, otherwise we wont be able to subsititute inside objects
  use({ "nvim-lualine/lualine.nvim" })
  use({ "windwp/nvim-autopairs" })
  use({ "vim-test/vim-test" })
  use({ "simrat39/symbols-outline.nvim" })
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
  use({ "ggandor/lightspeed.nvim", commit = "0b655" })

  -- Formatters
  use({ "sbdchd/neoformat" })
  use({ "ckipp01/stylua-nvim" })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Themes
  use({ "navarasu/onedark.nvim" })

  if should_bootsrap then
    require("packer").sync()
  end

  cmd("PackerInstall")
end)

local function setup_plugin_configs(config_files)
  for _, config_file in pairs(config_files) do
    require(config_file).setup()
  end
end

setup_plugin_configs({
  "config.dap",
  "config.dapui",
  "config.completion",
  "config.lsp",
  "config.tree-sitter",
  "config.auto-pairs",
  "config.harpoon",
  "config.nvim-tree",
  "config.symbols-outline",
  "config.telescope",
  "config.lualine",
  "config.null-ls",
  "config.gitsigns",
  "config.dashboard",
  "config.easyclip",
  "config.undotree",
  "config.undotree",
  "config.prettier",
})
