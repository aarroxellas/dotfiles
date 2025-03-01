local icons = require("ui.icons")
local M = {}

M.opts = {
	on_config_done = nil,
	breakpoint = {
	    text = icons.Bug,
	    texthl = "DiagnosticSignError",
	    linehl = "",
	    numhl = "",
	},
	breakpoint_rejected = {
	    text = icons.Bug,
	    texthl = "DiagnosticSignError",
	    linehl = "",
	    numhl = "",
	},
	stopped = {
	    text = icons.BoldArrowRight,
	    texthl = "DiagnosticSignWarn",
	    linehl = "Visual",
	    numhl = "DiagnosticSignWarn",
	},
	log = {
	    level = "info",
	},
	ui = {
	    auto_open = true,
	    notify = {
	        threshold = vim.log.levels.INFO,
	    },
	    config = {
	        icons = { expanded = "", collapsed = "", circular = "" },
	        mappings = {
	            -- Use a table to apply multiple mappings
	            expand = { "<CR>", "<2-LeftMouse>" },
	            open = "o",
	            remove = "d",
	            edit = "e",
	            repl = "r",
	            toggle = "t",
	        },
	        -- Use this to override mappings for specific elements
	        element_mappings = {},
	        expand_lines = true,
	        layouts = {
	            {
	                elements = {
	                    { id = "scopes", size = 0.33 },
	                    { id = "breakpoints", size = 0.17 },
	                    { id = "stacks", size = 0.25 },
	                    { id = "watches", size = 0.25 },
	                },
	                size = 0.33,
	                position = "right",
	            },
	            {
	                elements = {
	                    { id = "repl", size = 0.45 },
	                    { id = "console", size = 0.55 },
	                },
	                size = 0.27,
	                position = "bottom",
	            },
	        },
	        controls = {
	            enabled = true,
	            -- Display controls in this element
	            element = "repl",
	            icons = {
	                pause = "",
	                play = "",
	                step_into = "",
	                step_over = "",
	                step_out = "",
	                step_back = "",
	                run_last = "",
	                terminate = "",
	            },
	        },
	        floating = {
	            max_height = 0.9,
	            max_width = 0.5, -- Floats will be treated as percentage of your screen.
	            border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
	            mappings = {
	                close = { "q", "<Esc>" },
	            },
	        },
	        windows = { indent = 1 },
	        render = {
	            max_type_length = nil, -- Can be integer or nil.
	            max_value_lines = 100, -- Can be integer or nil.
	        },
	    },
	},
}

M.config = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		vim.notify("editor.dap not loaded", vim.log.levels.WARN, { title = "editor.dap" })
		return
	end

	vim.fn.sign_define("DapBreakpoint", M.opts.breakpoint)
	vim.fn.sign_define("DapBreakpointRejected", M.opts.breakpoint_rejected)
	vim.fn.sign_define("DapStopped", M.opts.stopped)

	dap.set_log_level(M.opts.log.level)
end

M.config_ui = function()
	local dap_ok, dap = pcall(require, "dap")
	if not dap_ok then
		vim.notify("editor.dap not loaded", vim.log.levels.WARN, { title = "editor.dapui" })
		return
	end

	local dapui_ok, dapui = pcall(require, "dapui")
	if not dapui_ok then
		vim.notify("editor.dapui not loaded", vim.log.levels.WARN, { title = "editor.dapui" })
		return
	end

	dapui.setup(M.opts.ui.config)

	dap.listeners.before.attach.dapui_config = function() dapui.open() end
	dap.listeners.before.launch.dapui_config = function() dapui.open() end
	dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
	dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

	-- DAP Globals
	local dap_map = function(lhs, rhs, desc)
		if desc then
			desc = "[DAP] " .. desc
		end

		vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
	end

	local status_dap, dap = pcall(require, "dap")
	if not status_dap then
		vim.notify("editor.dap.config_ui not loaded", vim.log.levels.WARN, { title = "editor.keymaps.dap" })
		return
	end

	local status_dapui, dapui = pcall(require, "dapui")
	if not status_dapui then
		vim.notify("editor.dapui.config_ui not loaded", vim.log.levels.WARN, { title = "editor.keymaps.dapui" })
		return
	end

	--
	dap_map("<F1>", dap.step_back, "step_back")
	dap_map("<F2>", dap.step_into, "step_into")
	dap_map("<F3>", dap.step_over, "step_over")
	dap_map("<F4>", dap.step_out, "step_out")
	dap_map("<F5>", dap.continue, "continue")
	dap_map("<leader>dr", dap.repl.open, "REPL")
	dap_map("<leader>db", dap.toggle_breakpoint, "Toggle [B]reak Point")
	dap_map("<leader>dB", function() dap.set_breakpoint(vim.fn.input("[DAP] Condition > ")) end, "Set Expression [B]reak Point")
	dap_map("<leader>dl", function() dap.list_breakpoints(true) end, "[L]ist All [B]reak Points")
	dap_map("<leader>dC", function() dap.clear_breakpoints() end, "[C]lear [B]reak Points")
	dap_map("<leader>de", dapui.eval, "[E]val UI")
	dap_map("<leader>dE", function() dapui.eval(vim.fn.input("[DAP] Expression > ")) end, "[E]xpression")
	dap_map("<leader>do", function() dapui.open() end, "[O]pen")
	dap_map("<leader>dc", function() dapui.close() end, "[C]lose")
	dap_map("<F7>", dapui.Toggle, "Open last session")

	vim.keymap.set("<leader>B", dap.toggle_breakpoint, "Toggle [B]reak Point")

-- vim.cmd([[
--         augroup DapRepl
--         au!
--         au FileType dap-repl lua require('dap.ext.autocompl').attach()
--         augroup END
--         ]])
end

return M
