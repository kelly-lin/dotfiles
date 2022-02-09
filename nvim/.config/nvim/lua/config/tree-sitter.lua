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
	},
})
