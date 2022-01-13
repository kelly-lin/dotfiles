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

require('lualine').setup { options = { theme = 'onedark' } }

require('onedark').setup { style = 'darker' }
require('onedark').load()
