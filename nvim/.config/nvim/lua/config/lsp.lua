local lsp_installer_loaded, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_loaded then
	return
end

local servers = {
  "bashls",
  "pyright",
  "yamlls",
  "tsserver",
  "vimls",
  "sumneko_lua",
  "gopls",
  "jsonls",
  "solargraph",
  "cmake",
  "kotlin_language_server",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local enhance_server_opts = {
  ["sumneko_lua"] = function (opts)
    opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim", "awesome" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
    }
  end,
  ["yamlls"] = function(opts)
    opts.settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					["../path/relative/to/file.yml"] = "/.github/workflows/*",
					["/path/from/root/of/project"] = "/.github/workflows/*",
				},
			},
    }
  end,
}

local bmap = require("utils.keymaps").bmap
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_installer.on_server_ready(function(server)
  local opts = {
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
  }

  if enhance_server_opts[server.name] then
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)
