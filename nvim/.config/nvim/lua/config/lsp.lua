local nvim_lsp_loaded, nvim_lsp = pcall(require, "lspconfig")
if not nvim_lsp_loaded then
	return
end

local bmap = require("utils.keymaps").bmap

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
	{
		"sumneko_lua",
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
		},
	},
	"pyright",
	"tsserver",
	"jsonls",
	"vimls",
	{
		"yamlls",
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					["../path/relative/to/file.yml"] = "/.github/workflows/*",
					["/path/from/root/of/project"] = "/.github/workflows/*",
				},
			},
		},
	},
	"solargraph",
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function getServerConfig(server)
	local server_name = ""
	local settings = {}
	if type(server) == "table" then
		server_name = server[1]
		settings = server.settings
	elseif type(server) == "string" then
		server_name = server
	else
		error("the specified server must be either a string or table")
	end
	return server_name, settings
end

for _, server in ipairs(servers) do
	local server_name, settings = getServerConfig(server)
	nvim_lsp[server_name].setup({
		on_attach = function(client, bufnr)
			bmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
			bmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
			bmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
			bmap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
			bmap(bufnr, "n", "<leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>", { silent = true })
			bmap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
			bmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
			bmap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
			bmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })

			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		settings = settings,
	})
end
