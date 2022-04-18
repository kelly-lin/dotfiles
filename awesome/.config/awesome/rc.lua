pcall(require, "luarocks.loader")

pcall(require, "awful.autofocus")
pcall(require, "awful.hotkeys_popup.keys")

require("utils").check_report_errors()

pcall(require, "main.theme")
pcall(require, "main.layouts")
pcall(require, "main.wibar")
pcall(require, "main.rules")
pcall(require, "main.signals")
pcall(require, "main.startup-apps")

pcall(require, "bindings.global")
pcall(require, "bindings.client")
