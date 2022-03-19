local M = {}

function M.require_guard(module)
  local ok, result = pcall(require, module)
  if not ok then
    return
  end
  return result
end

require("utils.keymaps")
require("utils.ag")

return M
