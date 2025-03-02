local M = {}

function M.config()
	local _ok, copilot = pcall(require, "copilot")
	if not _ok then
		vim.notify("completion.copilot not loaded", vim.log.levels.WARN, { title = "completion.copilot" })
		return
	end
	copilot.setup({
		panel = {
			keymap = {
				jump_next = "<m-j>",
				jump_prev = "<m-k>",
				accept = "<m-l>",
				refresh = "r",
				open = "<M-CR>",
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<m-l>",
				next = "<m-j>",
				prev = "<m-k>",
				dismiss = "<m-h>",
			},
		},
		filetypes = {
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
		copilot_node_command = "node",
	})
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<C-s>", ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

	local _ok_cmp, copilot_cmp = pcall(require, "copilot_cmp")
	if not _ok_cmp then
		vim.notify("completion.copilot copilot_cmp not loaded", vim.log.levels.WARN, { title = "completion.copilot.copilot_cmp" })
		return
	end
	copilot_cmp.setup()
end

return M
