local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  t = {
    -- name = "Rust",
    H = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Hints" },
    r = { "<cmd>RustRunnables<Cr>", "Runnables" },
    -- r = { "<cmd>lua _CARGO_RUN()<cr>", "Cargo Run" },
    t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
		-- j = { "<cmd>RustJoinLines<Cr>", "Join Lines" },
		-- s = { "<cmd>RustStartStandaloneServerForBuffer<Cr>", "Start Server Buf" },
		d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
		v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
		R = {
			"<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
			"Reload Workspace",
		},
		-- S = { "<cmd>RustSSR<Cr>", "SSR" },
		o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
		-- h = { "<cmd>RustSetInlayHints<Cr>", "Enable Hints" },
		-- H = { "<cmd>RustDisableInlayHints<Cr>", "Disable Hints" },
		-- a = { "<cmd>RustHoverActions<Cr>", "Hover Actions" },
		-- a = { "<cmd>RustHoverRange<Cr>", "Hover Range" },
		-- j = { "<cmd>RustMoveItemDown<Cr>", "Move Item Down" },
		-- k = { "<cmd>RustMoveItemUp<Cr>", "Move Item Up" },
	},
}


local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status_ok then
	vim.notify("rust-tools not loaded", vim.log.levels.WARN, { title = "ftplugin.rust" })
	return
end

local handlers = require("completion.lsp.handlers")
local on_attach = function (client, bufnr)
	vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
	vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
	handlers.lsp_keymaps(bufnr)
	which_key.register(mappings, opts)
end

local settings = {
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
		hover_actions = {
			auto_focus = true,
		},
		on_initialized = function()
			vim.cmd [[
			autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
			]]
		end,
	},
	server = {
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
		capabilities = handlers.capabilities,
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		}
	}
}

rust_tools.setup(settings)

