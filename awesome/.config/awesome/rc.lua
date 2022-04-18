pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local _ = require("awful.autofocus")
local naughty = require("naughty")
local menubar = require("menubar")
local _ = require("awful.hotkeys_popup.keys")

local function check_report_errors()
	if awesome.startup_errors then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, there were errors during startup!",
			text = awesome.startup_errors,
		})
	end
	do
		local in_error = false
		awesome.connect_signal("debug::error", function(err)
			if in_error then
				return
			end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
				text = tostring(err),
			})
			in_error = false
		end)
	end
end
check_report_errors()

local config = {
	user_vars = require("main.user-variables"),
	-- layouts = require("main.layouts"),
	-- tags = require("main.tags"),
	-- menu = require("main.menu"),
	-- rules = require("main.rules"),
}

local _ = require("main.theme")

local modkey = config.user_vars.modkey

local terminal = config.user_vars.terminal
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Layouts
local _ = require("main.layouts")
local _ = require("main.wibar")

-- Key bindings
local _ = require("bindings.global")
local _ = require("bindings.client")

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

require("main.rules")
require("main.signals")
require("main.startup-apps")
