local user_autocommands = vim.api.nvim_create_augroup('user_autocommands', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.kt,*.kts',
	command = [[ setlocal tabstop=2 shiftwidth=2 ]],
	group = user_autocommands,
})
