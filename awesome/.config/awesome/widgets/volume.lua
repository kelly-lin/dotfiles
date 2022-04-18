local wibox = require("wibox")
local M = {}

local function create_volume_text()
	if require("scripts.volume").is_muted() then
		return "VOL: MUTE"
	end
	return "VOL: " .. tostring(require("scripts.volume").get_volume()) .. "%"
end

M.widget = wibox.widget({
	text = create_volume_text(),
	widget = wibox.widget.textbox,
  align = "center",
  forced_width = 100
})

function M.update_volume()
	M.widget.text = create_volume_text()
end

return M
