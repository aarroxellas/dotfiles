local M = {}

function M.config()
	local ok, bufferline = pcall(require, "bufferline")
	if not ok then
		vim.notify("ui.bufferline", vim.log.levels.WARN, { title = "ui.bufferline" })
	end

	bufferline.setup({
		options = {
			numbers = "both", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
			close_command = "bdelete!", -- can be a string | function, see "Mouse actions"
			right_mouse_command = "bdelete!",
			left_mouse_command = "buffer %d",
			middle_mouse_command = nil,
			indicator_icon = nil,
			indicator = { style = "icon", icon = "▎" },
			buffer_close_icon = "",
			-- buffer_close_icon = '',
			modified_icon = "●",
			close_icon = "",
			-- close_icon = '',
			left_trunc_marker = "",
			right_trunc_marker = "",
			-- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
			--   -- remove extension from markdown files for example
			--   if buf.name:match('%.md') then
			--     return vim.fn.fnamemodify(buf.name, ':t:r')
			--   end
			-- end,
			max_name_length = 30,
			max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
			tab_size = 21,
			diagnostics = false, -- | "nvim_lsp" | "coc",
			diagnostics_update_in_insert = false,
			-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
			--   return "("..count..")"
			-- end,
            offsets = { -- Apply an offset for sidebar windows
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
            },
            {
                text = 'UndoTree',
                filetype = 'undotree',
                highlight = 'PanelHeading',
                separator = true,
            },
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
			enforce_regular_tabs = true,
			always_show_bufferline = true,
			-- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
			--   -- add custom logic
			--   return buffer_a.modified > buffer_b.modified
			-- end
		},
		-- highlights = {
		-- 	fill = {
		-- 		fg = { attribute = "fg", highlight = "#ff0000" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	background = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},

		-- 	-- buffer_selected = {
		-- 	--   fg = {attribute='fg',highlight='#ff0000'},
		-- 	--   bg = {attribute='bg',highlight='#0000ff'},
		-- 	--   gui = 'none'
		-- 	--   },
		-- 	buffer_visible = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},

		-- 	close_button = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	close_button_visible = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	-- close_button_selected = {
		-- 	--   fg = {attribute='fg',highlight='TabLineSel'},
		-- 	--   bg ={attribute='bg',highlight='TabLineSel'}
		-- 	--   },

		-- 	tab_selected = {
		-- 		fg = { attribute = "fg", highlight = "Normal" },
		-- 		bg = { attribute = "bg", highlight = "Normal" },
		-- 	},
		-- 	tab = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	tab_close = {
		-- 		-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
		-- 		fg = { attribute = "fg", highlight = "TabLineSel" },
		-- 		bg = { attribute = "bg", highlight = "Normal" },
		-- 	},

		-- 	duplicate_selected = {
		-- 		fg = { attribute = "fg", highlight = "TabLineSel" },
		-- 		bg = { attribute = "bg", highlight = "TabLineSel" },
		-- 		underline = true,
		-- 	},
		-- 	duplicate_visible = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 		underline = true,
		-- 	},
		-- 	duplicate = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 		underline = true,
		-- 	},

		-- 	modified = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	modified_selected = {
		-- 		fg = { attribute = "fg", highlight = "Normal" },
		-- 		bg = { attribute = "bg", highlight = "Normal" },
		-- 	},
		-- 	modified_visible = {
		-- 		fg = { attribute = "fg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},

		-- 	separator = {
		-- 		fg = { attribute = "bg", highlight = "TabLine" },
		-- 		bg = { attribute = "bg", highlight = "TabLine" },
		-- 	},
		-- 	separator_selected = {
		-- 		fg = { attribute = "bg", highlight = "Normal" },
		-- 		bg = { attribute = "bg", highlight = "Normal" },
		-- 	},
		-- 	-- separator_visible = {
		-- 	--   fg = {attribute='bg',highlight='TabLine'},
		-- 	--   bg = {attribute='bg',highlight='TabLine'}
		-- 	--   },
		-- 	indicator_selected = {
		-- 		fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
		-- 		bg = { attribute = "bg", highlight = "Normal" },
		-- 	},
		-- },
	})
end

return M
