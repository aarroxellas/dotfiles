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
	pattern = "markdown,tex,text,help,gitcommit",
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

-- Do not create comment on new line
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = user_autocommands,
	callback = function()
		vim.cmd "set formatoptions-=cro"
	end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.bo.filetype = "terminal"
  end,
})

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<space>;", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 14)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- LSP
vim.api.nvim_create_user_command('LspAddWorkSpace', function () vim.lsp.buf.add_workspace_folder() end, {})
vim.api.nvim_create_user_command('LspRemoveWorkSpace', function () vim.lsp.buf.remove_workspace_folder() end, {})

