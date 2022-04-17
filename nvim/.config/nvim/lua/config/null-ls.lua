local null_ls_loaded, null_ls = pcall(require, "null-ls")
if not null_ls_loaded then
	return
end

null_ls.setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.autopep8,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.completion.spell,
	},
})
