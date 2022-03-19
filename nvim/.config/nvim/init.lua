local sources = {
	"options",
	"plugins",
	"theme",
	"keymaps",
}

vim.cmd([[command! -nargs=1 Ag lua require("telescope").extensions.ag.search(<q-args>)]])

for _, source in ipairs(sources) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		error("Failed to load " .. source .. "\n\n" .. fault)
	end
end
