local M = {}

function M.config()
	local servers = {
		-- LUA
		"lua_ls",
		-- GO
		"gopls",
		-- Python
		"pyright",
		-- Kotlin
		"kotlin_language_server",
		-- Java
		"jdtls",
		-- JavaScript
		"ts_ls",
		-- Misc
		"jsonls",
		"yamlls",
		"graphql",
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

	for _, server in pairs(servers) do
		local handlers = require("completion.lsp.handlers")
        local on_attach = handlers.on_attach
        local opts = {
            on_attach = on_attach,
            capabilities = handlers.capabilities,
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "completion.lsp.settings." .. server)
        if require_ok then
			local set_root_dir = function(fname, root_files, fallback_root_files)
				return lspconfig.util.root_pattern(unpack(root_files))(fname) or lspconfig.util.root_pattern(unpack(fallback_root_files), vim.fn.getcwd())(fname)
			end

			local root_dir = set_root_dir(server, conf_opts.root_files, conf_opts.fallback_root_files)
            opts = vim.tbl_deep_extend("force", conf_opts.settings, opts)
			table.insert(opts, { root_dir = root_dir })
        end

		if server == "lua_ls" then
			require("neodev").setup {}
		end

		local manual_config_servers = { "jdtls", "rust_analyzer" }
        for _, s in ipairs(manual_config_servers) do
			if s == server then
				goto continue
			end
        end

        lspconfig[server].setup(opts)
        ::continue::
    end
end

return M
