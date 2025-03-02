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
end

return M
