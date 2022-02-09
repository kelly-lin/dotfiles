local toggleterm_loaded, toggleterm = pcall(require, "toggleterm")
if not toggleterm_loaded then
  return
end

toggleterm.setup({
	size = 25,
	open_mapping = [[``]],
})
