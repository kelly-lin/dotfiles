local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local modkey = require("main.user-variables").modkey
local gears = require("gears")
local terminal = require("main.user-variables").terminal
local volume_widget = require("widgets.volume")

local function setVolumeControlKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({}, "XF86AudioLowerVolume", function()
			volume_widget.decrease_volume()
			volume_widget.update_volume()
		end, { description = "decrease volume", group = "volume" }),

		awful.key({}, "XF86AudioRaiseVolume", function()
			volume_widget.increase_volume()
			volume_widget.update_volume()
		end, { description = "increase volume", group = "volume" }),

		awful.key({}, "XF86AudioMute", function()
			volume_widget.toggle_mute()
			volume_widget.update_volume()
		end, { description = "toggle mute", group = "volume" })
	)
end

local function setMediaControlKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey }, "F9", function()
			awful.util.spawn("playerctl -p spotify play-pause")
		end, { description = "play/pause", group = "spotify" }),

		awful.key({ modkey }, "F10", function()
			awful.util.spawn("playerctl -p spotify previous")
		end, { description = "previous", group = "spotify" }),

		awful.key({ modkey }, "F11", function()
			awful.util.spawn("playerctl -p spotify next")
		end, { description = "next", group = "spotify" })
	)
end

local function setTabNavigationKeys(globalkeys)
	return gears.table.join(
		globalkeys,
		awful.key({ modkey }, "p", awful.tag.viewprev, { description = "view previous", group = "tag" }),
		awful.key({ modkey }, "n", awful.tag.viewnext, { description = "view next", group = "tag" })
	)
end

local function setLayoutKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey, "Shift" }, "j", function()
			awful.client.swap.byidx(1)
		end, { description = "swap with next client by index", group = "client" }),

		awful.key({ modkey, "Shift" }, "k", function()
			awful.client.swap.byidx(-1)
		end, { description = "swap with previous client by index", group = "client" }),

		awful.key(
			{ modkey },
			"u",
			awful.client.urgent.jumpto,
			{ description = "jump to urgent client", group = "client" }
		),

		awful.key({ modkey }, "Tab", function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end, { description = "go back", group = "client" }),

		awful.key({ modkey }, "l", function()
			awful.tag.incmwfact(0.05)
		end, { description = "increase master width factor", group = "layout" }),

		awful.key({ modkey }, "h", function()
			awful.tag.incmwfact(-0.05)
		end, { description = "decrease master width factor", group = "layout" }),

		awful.key({ modkey, "Shift" }, "h", function()
			awful.tag.incnmaster(1, nil, true)
		end, { description = "increase the number of master clients", group = "layout" }),

		awful.key({ modkey, "Shift" }, "l", function()
			awful.tag.incnmaster(-1, nil, true)
		end, { description = "decrease the number of master clients", group = "layout" }),

		awful.key({ modkey, "Control" }, "h", function()
			awful.tag.incncol(1, nil, true)
		end, { description = "increase the number of columns", group = "layout" }),

		awful.key({ modkey, "Control" }, "l", function()
			awful.tag.incncol(-1, nil, true)
		end, { description = "decrease the number of columns", group = "layout" }),

		awful.key({ modkey }, "space", function()
			awful.layout.inc(1)
		end, { description = "select next", group = "layout" }),

		awful.key({ modkey, "Shift" }, "space", function()
			awful.layout.inc(-1)
		end, { description = "select previous", group = "layout" })
	)
end

local function setPromptKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey }, "d", function()
			awful.spawn([[rofi -show combi -combi-modes "window,run,ssh" -modes combi]])
		end, { description = "run rofi", group = "launcher" }),

		awful.key({ modkey }, "x", function()
			awful.prompt.run({
				prompt = "Run Lua code: ",
				textbox = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval",
			})
		end, { description = "lua execute prompt", group = "awesome" })
	)
end

local function setFocusKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey }, "j", function()
			awful.client.focus.byidx(1)
		end, { description = "focus next by index", group = "client" }),

		awful.key({ modkey }, "k", function()
			awful.client.focus.byidx(-1)
		end, { description = "focus previous by index", group = "client" })
	)
end

local function setAppLaunchKeys(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey }, "Return", function()
			awful.spawn(terminal)
		end, { description = "open a terminal", group = "launcher" }),

		awful.key({ modkey }, "c", function()
			awful.spawn("google-chrome-stable")
		end, { description = "open google chrome", group = "launcher" })
	)
end

local function setAwesomeControlKeys(globalkeys)
	return gears.table.join(
		globalkeys,
		awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

		awful.key({ modkey }, "Tab", awful.tag.history.restore, { description = "go back", group = "tag" }),

		awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

		awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" })

		-- awful.key({ modkey, "Control" }, "n", function()
		-- 	local c = awful.client.restore()
		-- 	-- Focus restored client
		-- 	if c then
		-- 		c:emit_signal("request::activate", "key.unminimize", { raise = true })
		-- 	end
		-- end, { description = "restore minimized", group = "client" })
	)
end

local function setMouseBindings(globalkeys)
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

	return globalkeys
end

local function setPowerControlBindings(globalkeys)
	return gears.table.join(
		globalkeys,

		awful.key({ modkey, "Shift" }, "7", function()
			awful.spawn("systemctl poweroff -i")
		end, { description = "power off", group = "power" }),

		awful.key({ modkey, "Shift" }, "8", function()
			awful.spawn("systemctl reboot")
		end, { description = "reboot", group = "power" }),

		awful.key({ modkey }, "9", function()
			awful.spawn("playerctl -p spotify pause")
			awful.spawn("xset dpms force off")
		end, { description = "away", group = "power" })
	)
end

globalkeys = setVolumeControlKeys(globalkeys)
globalkeys = setMediaControlKeys(globalkeys)
globalkeys = setTabNavigationKeys(globalkeys)
globalkeys = setLayoutKeys(globalkeys)
globalkeys = setPromptKeys(globalkeys)
globalkeys = setLayoutKeys(globalkeys)
globalkeys = setFocusKeys(globalkeys)
globalkeys = setAppLaunchKeys(globalkeys)
globalkeys = setAwesomeControlKeys(globalkeys)
globalkeys = setMouseBindings(globalkeys)
globalkeys = setPowerControlBindings(globalkeys)

root.keys(globalkeys)
