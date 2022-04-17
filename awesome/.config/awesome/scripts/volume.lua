local M = {}

local function get_volume()
	local handle = io.popen("pamixer --get-volume")
	local result = handle:read("*a")
	handle:close()
	return tonumber(result)
end

local function is_max_volume(max_volume)
	if get_volume() < max_volume then
		return false
	end
	return true
end

local max_volume = 60
local volume_step = 10
function M.increase_volume()
	if is_max_volume(max_volume) or max_volume - get_volume() < 10 then
		os.execute("pamixer --set-volume " .. max_volume)
		return
	end

	os.execute("pamixer -i " .. volume_step)
end

function M.decrease_volume()
	os.execute("pamixer -d " .. volume_step)
end

function M.toggle_mute()
	os.execute("pamixer -t")
end

return M
