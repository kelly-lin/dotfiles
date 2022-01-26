local M = {}

local user_config_dir = vim.fn.stdpath('data')
local user_config_path = user_config_dir .. '/prettier-dirs.json'

local function is_prettier_dir(filepath)
  local dirs = { '/home/kelly/Repos/personal/dotfiles/config/nvim/lua/kl' }
  for _, dir in pairs(dirs) do
    if string.find(filepath, dir) ~= nil then
      return true
    end
  end

  return false
end

function M.add_dir()

end

function M.Pretty()
  local filepath = vim.fn.expand('%')
  if is_prettier_dir(filepath) == false then
    print('is NOT prettier directory!')
    return
  end

  print('is prettier directory!')
  vim.cmd(':Prettier')
end

return M
