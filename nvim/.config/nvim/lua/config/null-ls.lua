local null_ls_loaded, null_ls = pcall(require, "null-ls")
if not null_ls_loaded then
	return
end

local M = {}

function M.setup()
	null_ls.setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.gofmt,
			require("null-ls").builtins.formatting.autopep8,
			require("null-ls").builtins.formatting.prettier,
			require("null-ls").builtins.diagnostics.eslint,
			require("null-ls").builtins.completion.spell,
			-- require("null-ls").builtins.completion.markdownlint,
			-- require("null-ls").builtins.completion.proselint,
		},
	})
end

return M
