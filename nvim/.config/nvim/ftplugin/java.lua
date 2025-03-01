local set = vim.opt_local
set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4
set.colorcolumn = "140"

local SYSTEM = "linux"
if vim.fn.has("mac") == 1 then SYSTEM = "mac" end

local mason_ok, mason_reg = pcall(require, 'mason-registry')

local HOME = os.getenv('HOME')
local jdtls_reg =  mason_reg.get_package('jdtls'):get_install_path()
local ECLIPSE_JDT_LS_JAR_PATH =  vim.fn.expand(jdtls_reg .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local ECLIPSE_JDT_LS_JAR_CONFIG_PATH = vim.fn.expand(jdtls_reg .. '/config_' .. SYSTEM)
local GOOGLE_STYLE_FORMAT_XML_PATH = vim.fn.expand(HOME .. '/.config/checkstyle/*.xml')
local check_style_reg = mason_reg.get_package('google-java-format'):get_install_path()
local GOOGLE_STYLE_FORMAT_JAR_PATH = vim.fn.expand(check_style_reg .. '/google-java-format-*.jar')
local LOMBOK_PATH =  vim.fn.expand(jdtls_reg .. '/lombok.jar')
local WORKSPACE_DIR = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local DATA_DIR = vim.fn.expand('~/.cache/nvim/workspaces_jdtls/' .. WORKSPACE_DIR)

local bundles = {}
-- vim.list_extend(bundles, vim.split( vim.fn.glob(jdtls_reg .. 'plugins', true), '\n'))
-- Debugging - Test
-- vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' ), "\n"))
-- vim.list_extend(bundles, vim.split(vim.fn.glob( HOME_PATH .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar' ), "\n"))


-- Use Mason: Debugging - Test
local java_debug_path = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
vim.list_extend(bundles, vim.split( vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true), '\n'))
local java_test_path = require('mason-registry').get_package('java-test'):get_install_path()
vim.list_extend(bundles, vim.split( vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n'))

local function keymaps(bufnr)
	-- keymaps LSP
	require("completion.lsp.handlers").lsp_keymaps(bufnr)

	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "<leader>lo", "<cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true, desc = "[O]rganize Imports" })
	keymap(bufnr, "n", "<leader>lC", "<cmd>lua require'jdtls'.compile('full')<CR>", { noremap = true, silent = true, desc = "[C]ompile Full" })
	keymap(bufnr, "n", "<leader>lc", "<cmd>lua require'jdtls'.compile('incremental')<CR>", { noremap = true, silent = true, desc = "[c]ompile Incremental" })
	keymap(bufnr, "n", "gS", "<cmd>lua require'jdtls'.super_implementation()<CR>", { noremap = true, silent = true, desc = "[G]o to Super Implementation" })
	keymap(bufnr, "n", "gs", "<cmd>lua require'jdtls.tests'.goto_subjects()<CR>", { noremap = true, silent = true, desc = "[G]o to Subjects" })
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

		wk.add({
				{ "<leader>le", group = "[E]xtract", nowait = true, remap = false },
		})
	end
end

local jdtls = require("jdtls")
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
local function jdtls_on_attach(client, bufnr)
	vim.lsp.codelens.refresh()
	local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
	-- local opts = {}
	-- if ok_cmp then opts = cmp_lsp.default_capabilities() end

	require('jdtls').setup_dap({hotcodereplace = 'auto'})
	-- require('jdtls.dap').setup_dap_main_class_configs(opts)

	keymaps(bufnr)
	vim.api.nvim_set_current_dir(client.config.root_dir)
end

local referenced_libs = vim.split(vim.fn.glob(vim.fn.getcwd() .. '/**/buildSrc.jar'), '\n')

local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-javaagent:' .. LOMBOK_PATH,
		'-jar', ECLIPSE_JDT_LS_JAR_PATH, GOOGLE_STYLE_FORMAT_JAR_PATH,
		'-configuration', ECLIPSE_JDT_LS_JAR_CONFIG_PATH,
		'-data', DATA_DIR
	},

	-- Wrapper jdtls installation
	-- cmd = {
	-- 	"jdtls",
	-- 	"--jvm-arg=-javaagent:" .. LOMBOK_PATH,
	-- 	"-configuration", vim.fn.expand("~/.cache/jdtls/config_" .. SYSTEM),
	-- 	"-data", DATA_DIR
	-- },

	root_dir = require("jdtls.setup").find_root({ "gradlew", "settings.gradle", ".git", "mvnw", "pom.xml", ".project" }),
	init_options = {
		bundles = bundles;
		extendedClientCapabilities = extendedClientCapabilities;
	},
	settings = {
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		java = {
			eclipse = { downloadSources = true, },
			maven = { downloadSources = true },
			configuration = {
				-- TODO: Move RunTimes to env file
				runtimes = {
					{
						name = "JavaSE-11",
						path = vim.fn.expand'$HOME/.asdf/installs/java/adoptopenjdk-11.*',
					},
					{
						name = "JavaSE-17",
						path = vim.fn.expand'$HOME/.asdf/installs/java/adoptopenjdk-17.*',
						default = true,
					},
					{
						name = "JavaSE-21",
						path = vim.fn.expand'$HOME/.asdf/installs/java/adoptopenjdk-21.*',
					},
					{
						name = "JavaSE-23",
						path = vim.fn.expand'$HOME/.asdf/installs/java/adoptopenjdk-23.*',
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
		server_side_fuzzy_completion = true,
	},
	on_attach = jdtls_on_attach;
}

jdtls.start_or_attach(config)
