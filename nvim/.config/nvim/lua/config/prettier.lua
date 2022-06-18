local M = {}

function M.setup()
	vim.cmd([[let g:prettier#autoformat_config_present = 1]])
end

return M
