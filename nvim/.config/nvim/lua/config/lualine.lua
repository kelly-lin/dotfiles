require("lualine").setup({
	options = {
		theme = "onedark",
		disabled_filetypes = { "NvimTree", "Outline", "dashboard" },
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
