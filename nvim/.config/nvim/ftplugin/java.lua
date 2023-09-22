local SYSTEM = "linux"
if vim.fn.has("mac") == 1 then SYSTEM = "mac" end

local HOME_PATH = os.getenv('HOME')
local ECLIPSE_JDT_LS_JAR_PATH =  HOME_PATH .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
local ECLIPSE_JDT_LS_JAR_CONFIG_PATH = HOME_PATH .. '/.local/share/jdtls/config_' .. SYSTEM
local GOOGLE_STYLE_FORMAT_XML_PATH = HOME_PATH .. '/.local/share/nvim/vscode-java-test/java-extension/build-tools/target/classes/checkstyle/checkstyle.xml'
local GOOGLE_STYLE_FORMAT_JAR_PATH = HOME_PATH .. '/.local/share/nvim/mason/packages/kotlin-language-server/server/lib/google-java-format-1.8.jar'
local LOMBOK_PATH =  HOME_PATH .. '/.local/share/jdtls/plugins/lombok.jar'
local WORKSPACE_DIR = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local bundles = {}
-- Debugging
vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar' ), "\n"))
-- vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar' ), "\n"))
-- From Mason
local java_debug_path = require('mason-registry')
	.get_package('java-debug-adapter')
	:get_install_path()
vim.list_extend(bundles, vim.split( vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'), '\n'))

local util = require('jdtls.util')
local dap = require("dap")

dap.adapters.java = function(callback)
	util.execute_command({ command = 'vscode.java.startDebugSession' }, function(err0, port)
		assert(not err0, vim.inspect(err0))
		callback({
			type = 'server',
			host = '127.0.0.1',
			port = port,
		})
	end)
end

-- vim.print(vim.inspect(bundles))

local function keymaps(bufnr)
	-- keymaps LSP
	require("completion.lsp.handlers").lsp_keymaps(bufnr)

	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "<leader>lo", "<cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true, desc = "[O]rganize Imports" })
	keymap(bufnr, "n", "<leader>lC", "<cmd>lua require'jdtls'.compile('full')<CR>", { noremap = true, silent = true, desc = "[C]ompile Full" })
	keymap(bufnr, "n", "<leader>lc", "<cmd>lua require'jdtls'.compile('incremental')<CR>", { noremap = true, silent = true, desc = "[c]ompile Incremental" })
	keymap(bufnr, "n", "gS", "<cmd>lua require'jdtls'.super_implementation()<CR>", { noremap = true, silent = true, desc = "[G]o to Super Implementation" })
	keymap(bufnr, "n", "<leader>dt", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true, desc = "[t]est Nearest Method" })
	keymap(bufnr, "n", "<leader>dT", "<cmd>lua require'jdtls'.test_class()<CR>", { noremap = true, silent = true, desc = "[T]est Class" })
	keymap(bufnr, "n", "<leader>dp", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true, desc = "[p]ick a test" })

	keymap(bufnr, "n", "<leader>lem", "<cmd>lua require'jdtls'.extract_method()<CR>", { noremap = true, silent = true, desc = "[e]xtract [m]ethod" })
	keymap(bufnr, "v", "<leader>lem", "<esc><cmd>lua require'jdtls'.extract_method()<CR>", { noremap = true, silent = true, desc = "[e]xtract [m]ethod" })
	keymap(bufnr, "n", "<leader>lev", "<cmd>lua require'jdtls'.extract_variable()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable" })
	keymap(bufnr, "v", "<leader>lev", "<esc><cmd>lua require'jdtls'.extract_variable()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable" })
	keymap(bufnr, "n", "<leader>leV", "<cmd>lua require'jdtls'.extract_variable_all()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable recurrences" })
	keymap(bufnr, "v", "<leader>leV", "<esc><cmd>lua require'jdtls'.extract_variable_all()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable recurrences" })
	keymap(bufnr, "n", "<leader>lec", "<cmd>lua require'jdtls'.extract_constant()<CR>", { noremap = true, silent = true, desc = "[e]xtract [c]onstant" })
	keymap(bufnr, "v", "<leader>lec", "<esc><cmd>lua require'jdtls'.extract_constant()<CR>", { noremap = true, silent = true, desc = "[e]xtract [c]onstant" })

	local ok_wk, wk = pcall(require, "which-key")
	if ok_wk then
		local opts = {
			mode = { "n", "v" },
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		wk.register({
			l = {
				e = { name = "[E]xtract" }
			}
		},
			opts
		)
	end
end

local jdtls = require("jdtls")
-- local bundles_dap = {
-- 	vim.fn.glob(
-- 		vim.fn.stdpath("data")
-- 			.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
-- 	),
-- }
-- local bundles_test = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar")
-- local bundles = vim.list_extend(bundles_dap, vim.split(bundles_test, "\n"))
-- local extendedClientCapabilities = jdtls.extendedClientCapabilities;
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
--
local function jdtls_on_attach(client, bufnr)
	require('jdtls').setup_dap({hotcodereplace = 'auto'})
	require('jdtls.dap').setup_dap_main_class_configs()

	keymaps(bufnr)
end


local config = {
	-- cmd = {
	-- 	'/home/aarroxellas/.asdf/installs/java/adoptopenjdk-17.0.7+7/bin/java',
	-- 	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	-- 	'-Dosgi.bundles.defaultStartLevel=4',
	-- 	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	-- 	'-Dlog.protocol=true',
	-- 	'-Dlog.level=ALL',
	-- 	'-Xms1g',
	-- 	'--add-modules=ALL-SYSTEM',
	-- 	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
	-- 	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
	-- 	'-javaagent:' .. LOMBOK_PATH,
	-- 	'-jar', ECLIPSE_JDT_LS_JAR_PATH, GOOGLE_STYLE_FORMAT_JAR_PATH,
	-- 	'-configuration', ECLIPSE_JDT_LS_JAR_CONFIG_PATH,
	-- 	'-data', vim.fn.expand('~/.cache/nvim/workspaces_jdtls/') .. WORKSPACE_DIR
	-- },
	-- Local jdtls installation
	cmd = {
		"/usr/local/bin/jdtls",
		"-configuration " .. vim.fn.expand("~/.cache/jdtls/config_" .. SYSTEM),
		'-data', vim.fn.expand('~/.cache/nvim/workspaces_jdtls/') .. WORKSPACE_DIR
	},

	-- cmd = {
	-- 	"java",
	-- 	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	-- 	"-Dosgi.bundles.defaultStartLevel=4",
	-- 	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	-- 	"-Dlog.protocol=true",
	-- 	"-Dlog.level=ALL",
	-- 	"-javaagent:" .. "/home/aarroxellas/.local/share/nvim/mason/packages/jdtls/lombok.jar",
	-- 	"-Xms1g",
	-- 	"--add-modules=ALL-SYSTEM",
	-- 	"--add-opens",
	-- 	"java.base/java.util=ALL-UNNAMED",
	-- 	"--add-opens",
	-- 	"java.base/java.lang=ALL-UNNAMED",
	-- 	"-jar " .. "/home/aarroxellas/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
	-- 	"-configuration " .. vim.fn.expand("~/.cache/jdtls/config_" .. SYSTEM),
	-- 	"-data " .. workspace_dir,
	-- },

	-- Mason install and config
	-- cmd = {
	-- vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"),
	-- "-configuration " .. vim.fn.stdpath("data") .. vim.fn.expand("~/.cache/jdtls"),
	-- },
	-- root_dir = jdtls_setup.find_root({ "gradlew", "*.gradle", ".git", "mvnw", ".mvn" }),
	root_dir = require("jdtls.setup").find_root({ "build.gradle", "pom.xml", ".git" }),
	init_options = {
		bundles = bundles;
		-- extendedClientCapabilities = extendedClientCapabilities;
	},
	settings = {
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		java = {
			-- home = "/home/aarroxellas/.asdf/installs/java/adoptopenjdk-17.0.7+7",
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = HOME_PATH .. "/.asdf/installs/java/adoptopenjdk-11.0.19+7",
					},
					{
						name = "JavaSE-17",
						path = HOME_PATH .. "/.asdf/installs/java/adoptopenjdk-17.0.7+7",
					},
					{
						name = "JavaSE-19",
						path = HOME_PATH .. "/.asdf/installs/java/adoptopenjdk-19.0.2+7",
					},
				},
				updateBuildConfiguration = "interactive",
			},
		},
		contentProvider = { preferred = "fernflower" },
		signatureHelp = { enabled = true },
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
		implementationsCodeLens = { enabled = true },
		referencesCodeLens = { enabled = true },
		references = { includeDecompiledSources = true },
		format = {
			enabled = true,
			settings = {
				url = GOOGLE_STYLE_FORMAT_XML_PATH,
				profile = "GoogleStyle",
			},
		},
		eclipse = { downloadSources = true, },
		quickfix = { enabled = true },
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	on_attach = jdtls_on_attach;
	-- capabilities = function()
	-- 	local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
	-- 	vim.tbl_deep_extend(
	-- 		'force',
	-- 		vim.lsp.protocol.make_client_capabilities(),
	-- 		ok_cmp and cmp_lsp.default_capabilities() or {}
	-- 	)
	-- end
	-- capabilities = require("lspconfig").util.default_config.capabilities,
}

-- config['on_attach'] = function (client, bufnr)
-- 	local jdtls_dap_ok, jdtls_dap = pcall(require, "jdtls.dap")
-- 	keymaps(bufnr)

-- 	if jdtls_dap_ok then
-- 		-- jdtls.setup_dap({ hotcodereplace = "auto" })
-- 		jdtls_dap.setup_dap_main_class_configs()
-- 	end
-- 	-- pcall(vim.lsp.codelens.refresh)

-- 	-- client.server_capabilities.documentFormattingProvider = false
-- 	-- client.server_capabilities.textDocument.completion.completionItem.snippetSupport = false

-- 	-- jdtls.update_project_config()
-- end


jdtls.start_or_attach(config)
