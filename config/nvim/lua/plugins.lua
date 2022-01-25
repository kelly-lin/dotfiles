local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local should_bootsrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  should_bootsrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

cmd 'packadd packer.nvim'
cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/popup.nvim'}, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-lua/completion-nvim' }

  use { 'machakann/vim-highlightedyank' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'rafamadriz/friendly-snippets' }

  use { 'glepnir/dashboard-nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'ThePrimeagen/harpoon' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'airblade/vim-gitgutter' }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'junegunn/fzf' }
  use { 'junegunn/fzf.vim' }
  use { 'mbbill/undotree' }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  use { 'svermeulen/vim-easyclip' }
  use { 'tpope/vim-unimpaired' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'vim-test/vim-test' }
  use { 'windwp/nvim-autopairs' }

  use { 'navarasu/onedark.nvim' }
  use { 'morhetz/gruvbox' }

  use { 'voldikss/vim-floaterm' }
  use { 'simrat39/symbols-outline.nvim' }

  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

  if should_bootsrap then
    require('packer').sync()
  end
end)

cmd 'PackerInstall'
