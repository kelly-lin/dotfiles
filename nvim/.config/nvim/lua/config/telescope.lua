local telescope_loaded, telescope = pcall(require, "telescope")
if not telescope_loaded then
	return
end

local M = {}

function M.setup()
	local actions = require("telescope.actions")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	telescope.load_extension("harpoon")
	telescope.load_extension("fzf")
	telescope.load_extension("ag")

	local nmap = require("utils.keymaps").nmap
	nmap("<leader>ff", "<cmd>Telescope find_files<CR>")
	nmap("<leader>ft", "<cmd>Telescope live_grep<CR>")
	nmap("<leader>fbs", "<cmd>Telescope buffers<CR>")
	nmap("<leader>fh", "<cmd>Telescope help_tags<CR>")
	nmap("<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>")
	nmap("<leader>fws", "<cmd>Telescope lsp_workspace_symbols<CR>")
	nmap("<leader>f:", "<cmd>Telescope command_history<CR>")
	nmap("<leader>fib", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

	nmap("<leader>fbr", "<cmd>Telescope git_branches<CR>")
	nmap("<leader>fgs", "<cmd>Telescope git_status<CR>")
	nmap("<leader>fpc", "<cmd>Telescope git_commits<CR>")
	nmap("<leader>fbc", "<cmd>Telescope git_bcommits<CR>")

	-- nmap('<leader>fts', '<cmd>Telescope treesitter<CR>')
	nmap("<leader>fr", "<cmd>Telescope lsp_references<CR>")
	nmap("<leader>fkm", "<cmd>Telescope keymaps<CR>")

	nmap(
		"<leader>fv",
		":lua require('telescope.builtin').find_files( { cwd = vim.fn.stdpath('config') })<CR>",
		{ silent = true }
	)

	nmap("<leader>ag", ":Ag<space>")
end

return M
