local servers = {
 	"lua_ls",
    -- "cssls",
    -- "html",
    -- "tsserver",
    "pyright",
    -- "jedi_language_server",
    -- "bashls",
    -- "jsonls",
    -- "yamlls",
    "kotlin_language_server",
    "jdtls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("completion.lsp.mason not loaded", vim.log.levels.WARN, { title = "completion.lsp.mason" })
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("completion.lsp.handlers").on_attach,
		capabilities = require("completion.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "completion.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
