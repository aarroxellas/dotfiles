local M = {}

function M.config()
	vim.keymap.set("n", "<leader>g-", vim.cmd.Git, {desc = "[G]it"})

	local bufnr = vim.api.nvim_get_current_buf()
	vim.keymap.set("n", "<leader>gp", function()
		vim.cmd.Git('push')
		end, {buffer = bufnr, remap = false, desc = "[G]it [p]ush"})

	-- rebase always
	vim.keymap.set("n", "<leader>gP", function()
		vim.cmd.Git({'pull',  '--rebase'})
		end, {buffer = bufnr, remap = false, desc = "[G]it [P]ull Rebase"})

	vim.keymap.set("n", "<leader>gt", "<cmd>Git push -u origin <CR>", {buffer = bufnr, remap = false, desc = "[G]it Branch Push [T]rack"})
	vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>", {desc = "[G]it Select Left"})
	vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<CR>", {desc = "[G]it Select Right"})
end

return M
