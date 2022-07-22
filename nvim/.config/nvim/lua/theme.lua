local onedark_loaded, onedark = pcall(require, "onedark")
if not onedark_loaded then
  return
end

onedark.setup({
  -- Main options --
  style = "darker",
  transparent = false,
  term_colors = true,
  ending_tildes = false,
  toggle_style_list = { "darker" },
  diagnostics = {
    darker = true,
    undercurl = true,
    background = true,
  },
})
require("onedark").load()

local function setup_custom_highlights()
  -- Set Telescope window colors
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#0c7fdd" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#0c7fdd" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#0c7fdd" })
  vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = "#abb2bf" })
end

setup_custom_highlights()
