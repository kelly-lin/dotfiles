local M = {}

function M.format()
	if vim.bo.filetype == "lua" then
		require("stylua-nvim").format_file()
	else
		vim.cmd([[PrettierAsync]])
	end
end

return M
