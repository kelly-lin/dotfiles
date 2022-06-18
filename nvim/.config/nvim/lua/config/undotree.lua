local M = {}

function M.setup()
	vim.g.undotree_SetFocusWhenToggle = 1

	local nmap = require("utils.keymaps").nmap
	nmap("<leader>z", ":UndotreeToggle<CR>", { silent = true })
end

return M
