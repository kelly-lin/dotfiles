local M = {}

function M.setup()
	vim.g.EasyClipAutoFormat = 0

	-- we are remapping to 'gs' from 's' because of a mapping clash with lightspeed
	local nmap = require("utils.keymaps").nmap
	local xmap = require("utils.keymaps").xmap
	nmap("gs", "<plug>SubstituteOverMotionMap", { silent = true, noremap = false })
	nmap("gss", "<plug>SubstituteLine", { noremap = false })
	xmap("gs", "<plug>XEasyClipPaste", { noremap = false })
end

return M
