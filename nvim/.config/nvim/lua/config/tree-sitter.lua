local treesitter_loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_loaded then
	return
end

treesitter.setup({
	ensure_installed = "maintained",
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	textobjects = {
		enable = true,
		lookahead = true,
		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.inner",
			["ia"] = "@parameter.outer",
			["as"] = "@statement.outer",
		},
	},
})
