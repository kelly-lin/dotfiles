local lualine_loaded, lualine = pcall(require, "lualine")
if not lualine_loaded then
  return
end

lualine.setup({
	options = {
		disabled_filetypes = { "NvimTree", "Outline", "dashboard", "fugitive" },
	},
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 2,
			},
		},
		lualine_x = { "encoding", "filetype" },
	},
	inactive_sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 2,
			},
		},
	},
})
