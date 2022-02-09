local onedark_loaded, onedark = pcall(require, "onedark")
if not onedark_loaded then
	return
end

onedark.setup({
	-- Main options --
	style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'

	-- Plugins Config --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = false, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
})
require("onedark").load()
