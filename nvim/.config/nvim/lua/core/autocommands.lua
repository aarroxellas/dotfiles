local function strip_trailing_whitespace()
	if vim.bo.modifiable then
		local line = vim.fn.line(".")
		local col = vim.fn.col(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.histdel("/", -1)
		vim.fn.cursor(line, col)
	end
end

local user_autocommands = vim.api.nvim_create_augroup("user_autocommands", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = strip_trailing_whitespace,
	group = user_autocommands,
})
-- vim.api.nvim_create_autocmd('BufEnter', {
-- 	pattern = '*',
-- 	command = [[ if &filetype == "" | setlocal ft=text | endif]],
-- 	group = user_autocommands,
-- })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown,text,help",
	command = "setlocal spelllang=en | setlocal spell",
	group = user_autocommands,
})
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = [[setlocal nonumber norelativenumber]],
	group = user_autocommands,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=conf",
	group = user_autocommands,
})

-- Auto Close LSP quicklist
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*" },
	command = "if &buftype == 'quickfix'|q|endif",
	group = user_autocommands,
})

-- LSP
vim.api.nvim_create_user_command('LspAddWorkSpace', function () vim.lsp.buf.add_workspace_folder() end, {})
vim.api.nvim_create_user_command('LspRemoveWorkSpace', function () vim.lsp.buf.remove_workspace_folder() end, {})

