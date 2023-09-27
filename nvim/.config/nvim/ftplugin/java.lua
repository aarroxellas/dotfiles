local SYSTEM = "linux"
if vim.fn.has("mac") == 1 then SYSTEM = "mac" end

local HOME = os.getenv('HOME')
local ECLIPSE_JDT_LS_JAR_PATH =  vim.fn.glob(HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')
local ECLIPSE_JDT_LS_JAR_CONFIG_PATH = vim.fn.glob(HOME .. '/.local/share/nvim/mason/share/jdtls/config')
local GOOGLE_STYLE_FORMAT_XML_PATH = vim.fn.glob(HOME .. '/.config/checkstyle/google_checks.xml')
local GOOGLE_STYLE_FORMAT_JAR_PATH = vim.fn.glob(HOME .. '/.local/share/nvim/mason/packages/google-java-format/google-java-format-*.jar')
local LOMBOK_PATH =  vim.fn.glob(HOME .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar')
local WORKSPACE_DIR = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local bundles = {}
-- Debugging
-- vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' ), "\n"))
-- vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar' ), "\n"))
-- From Mason
local java_debug_path = require('mason-registry') .get_package('java-debug-adapter'):get_install_path()
vim.list_extend(bundles, vim.split( vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'), '\n'))
local java_test_path = require('mason-registry') .get_package('java-test'):get_install_path()
vim.list_extend(bundles, vim.split( vim.fn.glob(java_test_path .. '/extension/server/*.jar'), '\n'))
-- local java_jdtls_adds = require('mason-registry') .get_package('jdtls'):get_install_path()
-- vim.list_extend(bundles, vim.split( vim.fn.glob(java_jdtls_adds .. '/plugins/*.jar'), '\n'))

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
	keymap(bufnr, "n", "<leaderlua require('jdtls').update_project_config()>lem", "<cmd>lua require'jdtls'.extract_method()<CR>", { noremap = true, silent = true, desc = "[e]xtract [m]ethod" })
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
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

local function jdtls_on_attach(client, bufnr)
	vim.lsp.codelens.refresh()
	local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
	local opts = {}
	if ok_cmp then opts = cmp_lsp.default_capabilities() end

	require('jdtls').setup_dap({hotcodereplace = 'auto'})
	require('jdtls.dap').setup_dap_main_class_configs(opts)

	keymaps(bufnr)
end

local config = {
	-- cmd = {
	-- 	'java',
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
	-- 	'-data', vim.fn.expand('~/.cache/nvim/workspaces_jdtls/' .. WORKSPACE_DIR)
	-- },

	-- Local jdtls installation
	cmd = {
		"/home/aarroxellas/.local/share/jdtls/bin/jdtls",
		'--jvm-arg=-javaagent:' .. LOMBOK_PATH,
		"-configuration " .. ECLIPSE_JDT_LS_JAR_CONFIG_PATH,
		'-data', vim.fn.expand('~/.cache/nvim/workspaces_jdtls/' .. WORKSPACE_DIR),
	},

	root_dir = require("jdtls.setup").find_root({ "gradlew", ".gradle",	"settings.gradle",	"settings.gradle.kts" , ".git", "mvnw" }),
	init_options = {
		bundles = bundles;
		extendedClientCapabilities = extendedClientCapabilities;
	},
	settings = {
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		java = {
			eclipse = { downloadSources = true, },
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = HOME .. "/.asdf/installs/java/adoptopenjdk-11.0.20+101",
					},
					-- {
					-- 	name = "JavaSE-17",
					-- 	path = HOME .. "/.asdf/installs/java/adoptopenjdk-17.0.8+101",
					-- },
					{
						name = "JavaSE-17",
						path = HOME .. "/.asdf/installs/java/temurin-17.0.5+8",
						default = true,
					},
					{
						name = "JavaSE-19",
						path = HOME .. "/.asdf/installs/java/adoptopenjdk-19.0.2+7",
					},
				},
				updateBuildConfiguration = "interactive",
			},
			import = {
				gradle = { enabled = true },
				maven = { enabled = true },
			},
			implementationsCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			format = {
				enabled = true,
				settings = {
					url = GOOGLE_STYLE_FORMAT_XML_PATH,
					profile = "GoogleStyle",
				},
			},
			quickfix = { enabled = true },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
			referencesCodeLens = { enabled = true },
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	on_attach = jdtls_on_attach;
}

vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"

jdtls.start_or_attach(config)
