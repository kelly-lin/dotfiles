local autopairs_loaded, autopairs = pcall("nvim-autopairs")
if not autopairs_loaded then
	return
end

autopairs.setup({})
