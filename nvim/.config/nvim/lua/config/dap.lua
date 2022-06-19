local dap_loaded, dap = pcall(require, "dap")
if not dap_loaded then
  return
end

local function get_debug_server_dir()
  return os.getenv("HOME") .. "/.debug-servers"
end

local M = {}

function M.setup()
  dap.adapters.python = {
    type = "executable",
    command = get_debug_server_dir() .. "/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
  }

  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { get_debug_server_dir() .. "/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
  }

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch file",
      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end,
    },
  }

  dap.configurations.javascriptreact = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }

  dap.configurations.typescriptreact = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
end

return M
