local M = {}

M.settings = {
	gopls = {
		gofumpt = true,
		completeUnimported = true,
		usePlaceholders = true,
		analyses = {
			unusedparams = true,
		},
	},
}

M.flags = {
	debounce_text_changes = 150,
}

M.root_files = { 'go.mod', 'go.sum', 'go.work' }
M.fallback_root_files = { '.git' }

return M
