local M = {}

local function mergeOptions(opts)
  local result = { noremap = true }
  if opts then
      result = vim.tbl_extend('force', result, opts)
  end
  return result
end

function M.map(mode, lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nbMapset_keymap(mode, lhs, rhs, options)
end

function M.bmap(bufnr, mode, lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.imap(lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_set_keymap('i', lhs, rhs, options)
end

function M.vmap(lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_set_keymap('v', lhs, rhs, options)
end

function M.xmap(lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_set_keymap('x', lhs, rhs, options)
end

function M.nmap(lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_set_keymap('n', lhs, rhs, options)
end

function M.tmap(lhs, rhs, opts)
  local options = mergeOptions(opts)
  vim.api.nvim_set_keymap('t', lhs, rhs, options)
end

return M
