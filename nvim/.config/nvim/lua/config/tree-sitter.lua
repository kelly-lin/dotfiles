local treesitter_loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_loaded then
	return
end

treesitter.setup({
	ensure_installed = {
		"javascript",
		"ruby",
		"typescript",
		"lua",
		"yaml",
		"bash",
		"cmake",
		"css",
		"dockerfile",
		"html",
		"json",
		"kotlin",
		"make",
		"python",
		"regex",
		"tsx",
		"vim",
	},
	sync_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["as"] = "@statement.outer",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["ak"] = "@block.inner",
				["ik"] = "@block.outer",
			},
		},
	},
})
