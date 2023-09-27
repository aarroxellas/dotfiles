local M = {}

M.settings = {
	gopls = {
		gofumpt = true,
	},
}

M.flags = {
	debounce_text_changes = 150,
}

M.root_files = { 'go.mod', 'go.sum' }
M.fallback_root_files = { '.git' }

return M
