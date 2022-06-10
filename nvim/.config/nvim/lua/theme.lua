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
