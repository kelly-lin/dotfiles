local bmap = require('utils').bmap

local function on_attach(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
  bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
  bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
  bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
  bmap(bufnr, 'n', '<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
  -- bmap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { silent = true })
  -- bmap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { silent = true })
  -- bmap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { silent = true })
  bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
  bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })
  bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
  bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
end

local lsp_servers_dir = vim.fn.stdpath('data') .. '/lsp_servers'

local function makeOpts(server_name, common_opts)
  local result = {}
  local server_opts = {}

  if server_name == 'html' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/html/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server' },
    }
  end

  if server_name == 'jsonls' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/jsonls/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server' },
    }
  end

  if server_name == 'kotlin_language_server' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/kotlin/server/bin/kotlin-language-server' },
    }
  end

  if server_name == 'pyright' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/kotlin/server/bin/kotlin-language-server' },
    }
  end

  if server_name == 'sumneko_lua' then
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    server_opts = {
      cmd = { lsp_servers_dir .. '/sumneko_lua/extension/server/bin/lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end

  if server_name == 'tsserver' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/tsserver/node_modules/typescript/bin/tsserver' },
    }
  end

  if server_name == 'vimls' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/vim/node_modules/vim-language-server/bin/index.js' },
    }
  end

  if server_name == 'yamlls' then
    server_opts = {
      cmd = { lsp_servers_dir .. '/yaml/node_modules/yaml-language-server/bin/yaml-language-server' },
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            ['../path/relative/to/file.yml'] = '/.github/workflows/*',
            ['/path/from/root/of/project'] = '/.github/workflows/*',
          },
        },
      },
    }
  end

  result = vim.tbl_extend('force', common_opts, server_opts)

  return result
end

-- local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local servers = { 'sumneko_lua', 'pyright', 'cmake', 'tsserver', 'html', 'jsonls', 'vimls', 'yamlls', 'kotlin_language_server' }
local common_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

for _, server_name in pairs(servers) do
  local server_available, server = lsp_installer_servers.get_server(server_name)
  if server_available then
    server:on_ready(function ()
      -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
      -- this function will be invoked. Make sure not to use the 'catch-all' lsp_installer.on_server_ready()
      -- function to set up servers, to avoid doing setting up a server twice.
      local opts = makeOpts(server_name, common_opts)
      server:setup(opts)
    end)

    if not server:is_installed() then
      server:install()
    end
  end
end
