vim.g.dashboard_custom_header = {
	[[    _   __            _    __ _          ]],
	[[   / | / /___   ____ | |  / /(_)____ ___ ]],
	[[  /  |/ // _ \ / __ \| | / // // __ `__ \]],
	[[ / /|  //  __// /_/ /| |/ // // / / / / /]],
	[[/_/ |_/ \___/ \____/ |___//_//_/ /_/ /_/ ]],
}

vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
	a = { description = { "   Find File                 SPC f f" }, command = "Telescope find_files" },
	b = { description = { "   Recents                   SPC f o" }, command = "Telescope oldfiles" },
	c = { description = { "   Find Word                 SPC f t" }, command = "Telescope live_grep" },
	e = { description = { "   Last Session              SPC s l" }, command = "SessionLoad" },
}
