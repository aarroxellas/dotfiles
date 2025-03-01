local M = {}

function M.config()
	require("neotest-python")({
		dap = { justMyCode = false },
	})
	require("neotest-plenary")
	-- require("neotest-vim-test")({
	-- 	ignore_file_types = { "python", "vim", "lua" },
	-- })

	require("neodev").setup({
		library = { plugins = { "neotest" }, types = true },
	})

	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				return message
			end,
		},
	}, neotest_ns)
	require("neotest").setup({
		adapters = {
			require "neotest-vim-test" {
				ignore_file_types = { "python", "vim", "lua", "java", "javascript", "typescript" },
			},
			require("neotest-java")({ ignore_wrapper = false }),
			require("neotest-go")({ dap = { justMyCode = false }, }),
			require("neotest-python")({
				dap = { justMyCode = false },
				args = {"--log-level", "DEBUG"},
				runner = "pytest",
				-- python = ".venv/bin/python",
				-- is_test_file = function(file_path) ... end,
			}),
			-- EXPERIMENTAL
			-- pytest_discover_instances = true,
		},
	})
end

return M
