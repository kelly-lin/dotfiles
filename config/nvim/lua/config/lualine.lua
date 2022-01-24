require('lualine').setup {
  options = {
    theme = 'onedark',
    disabled_filetypes = { 'NvimTree', 'Outline' }
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 2
      }
    },
  }
}
