local dapui_loaded, dapui = pcall(require, "dapui")
if not dapui_loaded then
  return
end

local M = {}

function M.setup()
  dapui.setup()
end

return M
