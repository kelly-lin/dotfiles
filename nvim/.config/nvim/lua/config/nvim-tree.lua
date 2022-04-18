local nvim_tree_loaded, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_loaded then
	return
end

nvim_tree.setup({
	filters = {
		dotfiles = false,
		custom = {
			".git",
			"node_modules",
			".cache",
		},
	},
	disable_netrw = true,
	hijack_netrw = true,
	ignore_ft_on_setup = {
		"dashboard",
		"startify",
		"alpha",
	},
	open_on_tab = false,
	quit_on_open = false,
	hijack_cursor = true,
	hide_root_folder = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		ignore_list = {},
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 40,
		height = 30,
		side = "left",
		allow_resize = true,
		hide_root_folder = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 0,
		tree_width = 30,
	},
})

local nmap = require("utils.keymaps").nmap
nmap("<leader>ef", ":NvimTreeToggle<CR>", { silent = true })
