local autopairs_loaded, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_loaded then
	return
end

local M = {}

function M.setup()
	autopairs.setup({})
end

return M
