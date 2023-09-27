local M = {}

M,settings = {
	Lua = {
		diagnostics = {
			globals = { "vim" },
		},
		workspace = {
			library = {
				[vim.fn.expand "$VIMRUNTIME/lua"] = true,
				[vim.fn.stdpath "config" .. "/lua"] = true,
			},
		},
		telemetry = {
			enable = false,
		},
	},
}

M.root_files = { 'init.lua' }
M.fallback_root_files = { '.git' }

return M
