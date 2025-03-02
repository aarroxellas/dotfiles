local M = {}

---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme
function M.config()
	local ok_telescope, telescope = pcall(require, "telescope")
	if not ok_telescope then
		vim.notify("ui.telescope not loaded", vim.log.levels.WARN, { title = "ui.telescope" })
		return
	end

	local ok_telescope_actions, actions = pcall(require, "telescope.actions")
	if not ok_telescope_actions then
		vim.notify("ui.telescope_actions not loaded", vim.log.levels.WARN, { title = "ui.telescope" })
		return
	end

	local theme = "ivy"

	telescope.setup({
		theme = "dropdown", ---@type telescope_themes
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			prompt_prefix = "❱ ",
			selection_caret = "❱ ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-c>"] = actions.close,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-q>"] = function(...)
						actions.smart_send_to_qflist(...)
						actions.open_qflist(...)
					end,
					["<CR>"] = actions.select_default,
				},
				n = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-q>"] = function(...)
						actions.smart_send_to_qflist(...)
						actions.open_qflist(...)
					end,
				},
			},
			file_ignore_patterns = { ".git/", "node_modules", "%.class", "bin", "%.jar", "%.lock" },
			path_display = { "smart" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			color_devicons = true,
			use_less = false,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default { },
		},
		pickers = {
			find_files = {
				find_command = { "fd", "-I" }, -- do not ignore files in .gitignore
				hidden = true,
				theme = theme,
			},
			live_grep = {
				theme = theme,
			},
			grep_string = {
				theme = theme,
			},
			buffers = {
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
				theme = theme,
			},
			planets = {
				show_pluto = true,
				show_moon = true,
				theme = theme,
			},
			git_files = {
				hidden = true,
				show_untracked = true,
				theme = theme,
			},
			colorscheme = {
				enable_preview = true,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- "ignore_case", "respect_case"
			},
		},
	})
end

return M
