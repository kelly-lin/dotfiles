local wibox = require("wibox")
local M = {}

local function create_volume_text()
	if require("scripts.volume").is_muted() then
		return "VOL: MUTE"
	end
	return "VOL: " .. tostring(require("scripts.volume").get_volume()) .. "%"
end

local volume_widget = wibox.widget({
	text = create_volume_text(),
	widget = wibox.widget.textbox,
})
M.widget = volume_widget

function M.update_volume()
	volume_widget.text = create_volume_text()
end

return M
