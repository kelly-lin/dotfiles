local wibox = require("wibox")
local M = {}

function M.get_volume()
	local handle = io.popen("pamixer --get-volume")
	local result = handle:read("*a")
	handle:close()
	return tonumber(result)
end

local function is_max_volume(max_volume)
	if M.get_volume() < max_volume then
		return false
	end
	return true
end

function M.is_muted()
	local handle = io.popen("pamixer --get-mute")
	local result = handle:read("*a")
	handle:close()
	result = string.gsub(result, "\n", "")
	if result == "false" then
		return false
	end
	return true
end

local max_volume = 100
local volume_step = 10
function M.increase_volume()
	if M.is_muted() then
		M.toggle_mute()
		return
	end

	if is_max_volume(max_volume) or max_volume - M.get_volume() < 10 then
		os.execute("pamixer --set-volume " .. max_volume)
		return
	end

	os.execute("pamixer -i " .. volume_step)
end

function M.decrease_volume()
	if M.is_muted() then
		M.toggle_mute()
		return
	end

	os.execute("pamixer -d " .. volume_step)
end

function M.toggle_mute()
	os.execute("pamixer -t")
end

local function create_volume_text()
	if M.is_muted() then
		return "VOL: MUTE"
	end
	return "VOL: " .. tostring(M.get_volume()) .. "%"
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
