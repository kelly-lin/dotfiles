local harpoon_loaded, harpoon = pcall(require, "harpoon")
if not harpoon_loaded then
	return
end

local M = {}

function M.setup()
	harpoon.setup({
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = false,
		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,
		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,
		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = false,
		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },
	})

	local nmap = require("utils.keymaps").nmap

	nmap("<leader>ha", [[:lua require("harpoon.mark").add_file()<CR>:echo 'Added harpoon mark'<CR>]])
	nmap([[<leader>']], [[:Telescope harpoon marks<CR>]])
end

return M
