local bmap = require("utils").bmap

local function on_attach(_, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	bmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
	bmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
	bmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
	bmap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
	-- bmap(bufnr, 'n', '<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
	-- bmap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { silent = true })
	-- bmap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { silent = true })
	-- bmap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { silent = true })
	bmap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
	bmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
	bmap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
	bmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local nvim_lsp = require('lspconfig')
local servers = { 'sumneko_lua', 'pyright', 'tsserver', 'jsonls', 'vimls', 'yamlls', 'solargraph' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
	local settings = {}
	if lsp == "sumneko_lua" then
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		}
	end

	if lsp == "yamlls" then
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					["../path/relative/to/file.yml"] = "/.github/workflows/*",
					["/path/from/root/of/project"] = "/.github/workflows/*",
				},
			},
		}
	end

	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		settings = settings,
	})
end

-- Disable nvim lsp inline diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false
--   }
-- )
