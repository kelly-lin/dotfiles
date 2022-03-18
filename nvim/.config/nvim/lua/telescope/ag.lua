local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")

local M = {}

function M.ag(text_to_find)
	local default_opts = {
		entry_maker = function(entry)
			local split = vim.split(entry, ":")
			local filepath = vim.fn.getcwd() .. "/" .. split[1]
			local line_num = tonumber(split[2])
			local display = function(entry)
				local hl_group
				local display = utils.transform_path({}, entry.value)

				display, hl_group = utils.transform_devicons(entry.path, display, false)

				if hl_group then
					return display, { { { 1, 3 }, hl_group } }
				else
					return display
				end
			end
			return {
				value = entry,
				display = display,
				ordinal = filepath,
				path = filepath,
				lnum = line_num,
			}
		end,
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				vim.cmd(":e " .. "+" .. selection.lnum .. " " .. selection.path)
			end)
			return true
		end,
	}
	local opts = default_opts

	local args = { "ag", text_to_find }
	pickers.new(opts, {
		prompt_title = "Silver Searcher",
		finder = finders.new_oneshot_job(args, opts),
		previewer = conf.grep_previewer(opts),
		sorter = conf.file_sorter(opts),
	}):find()
end

M.ag()

return M
