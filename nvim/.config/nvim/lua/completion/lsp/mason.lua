local servers = {
 	"lua_ls",
    -- "cssls",
    -- "html",
    -- "tsserver",
    "gopls",
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
    local on_attach = require("completion.lsp.handlers").on_attach
    local capabilities = require("completion.lsp.handlers").capabilities
    opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "completion.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    if server == "gopls" then
        local go_opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    gofumpt = true,
                },
            },
            flags = {
                debounce_text_changes = 150,
            },
        }
        lspconfig[server].setup(go_opts)
        -- TODO: rethink keymapping
        require("completion.lsp.handlers").lsp_keymaps(0)
        goto continue
    end

    if server == "rust-analyzer" then
        local rust_opts = require "completion.lsp.settings.rust"
        local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
        if not rust_tools_status_ok then
            vim.notify("completion.lsp.rust-tools not loaded", vim.log.levels.WARN, { title = "completion.lsp.completion.rust" })
            return
        end

        rust_tools.setup(rust_opts)

        -- TODO: rethink keymapping
        require("completion.lsp.handlers").lsp_keymaps(0)
        goto continue
    end

    if server == "kotlin_language_server" then
        local kopts = require("completion.lsp.settings.kotlin_langrage_server")
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = kopts.root_dir,
            filetypes = kopts.filetypes,
            -- cmd = { 'kotlin_language_server' },
        })
        goto continue
    end

    -- TODO: Config. Java
    if server == "jdtls" then
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
