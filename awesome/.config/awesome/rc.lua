pcall(require, "luarocks.loader")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

require("utils").check_report_errors()

local config = {
	user_vars = require("main.user-variables"),
}

require("main.theme")

local terminal = config.user_vars.terminal
local menubar = require("menubar")
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

require("main.layouts")
require("main.wibar")

require("bindings.client")
require("bindings.global")

require("main.rules")
require("main.signals")
require("main.startup-apps")
