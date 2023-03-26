local user_autocommands = vim.api.nvim_create_augroup('user_autocommands', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.kt,*.kts',
	command = [[ setlocal tabstop=2 shiftwidth=2 ]],
	group = user_autocommands,
})
local function strip_trailing_whitespace()
	if vim.bo.modifiable then
		local line = vim.fn.line('.')
		local col = vim.fn.col('.')
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.histdel('/', -1)
		vim.fn.cursor(line, col)
	end
end

local vimrc_group = vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = strip_trailing_whitespace,
	group = vimrc_group,
})
-- vim.api.nvim_create_autocmd('BufEnter', {
-- 	pattern = '*',
-- 	command = [[ if &filetype == "" | setlocal ft=text | endif]],
-- 	group = vimrc_group,
-- })
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown,text,help',
	command = 'setlocal spelllang=en,pt,fr | setlocal spell',
	group = vimrc_group,
})
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = [[setlocal nonumber norelativenumber]],
	group = vimrc_group,
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
	pattern = '*',
	command = [[if &nu | set rnu | endif]],
	group = vimrc_group,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
	pattern = '*',
	command = [[if &nu | set nornu | endif]],
	group = vimrc_group,
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
	pattern = '.env*',
	command = 'set filetype=conf',
    group = vimrc_group,
})
