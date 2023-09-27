local lspconfig = require"lspconfig"

local M = {}

M.root_files = {
	'.graphqlrc*',
	'.graphql.config.*',
	'graphql.config.*',
	'*.graphqls',
}

M.fallback_root_files = { ".git" }

return M
