local M = {}

function M.config()
	local ok, _ = pcall(require, "indent_blankline")
	if not ok then
		vim.notify("ui.indent_blankline not loaded", vim.log.levels.WARN, { title = "ui.indent_blankline" })
		return
	end

	local highlight = {
		"CursorColumn",
		"Whitespace",
		"Function",
		"Label",
	}
	local opts = {
		indent = {
			char = "│", -- { '|', '¦', '┆', '┊' } -- each indent level has a distinct character.
			highlight = highlight,
		},
		whitespace = {
			remove_blankline_trail = false,
		},
	}

	require("ibl").setup(opts)
end

return M
