require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  sync_install = false,
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

require('lualine').setup {
  options = {
    theme = 'onedark',
    disabled_filetypes = { 'NvimTree', 'Outline' }
  }
}



