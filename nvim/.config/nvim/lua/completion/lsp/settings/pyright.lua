local M = {}

M.settings = {
	single_file_support = true,
	python = {
		analysis = {
			typeCheckingMode = "off",
			diagnosticMode = "workspace",
			autoImportCompletions = true,
			useLibraryCodeForTypes = true,
		},
	},
}

M.root_files = {}
M.fallback_root_files = { '.git' }

return M
