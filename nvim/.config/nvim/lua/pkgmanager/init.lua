require("pkgmanager.bootstrap")()

local status_lazy, lazy = pcall(require, "lazy")
if not status_lazy then
	vim.notify("skipping loading plugins until lazy.nvim is installed", vim.log.levels.WARN, { title = "pkg_manager.bootstrap" })
	return
else
	-- auto sync when saving init.lua file
	local package_manager_group = vim.api.nvim_create_augroup("package_manager", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "init.lua",
		callback = function () lazy.sync() end,
		group = package_manager_group,
	}
	)
end

local plugins_dir = vim.call("stdpath", "data")
-- remove plugins from rtp before loading lazy
vim.opt.runtimepath:remove(table.concat({ plugins_dir, "*" }, '/'))

local ui = require("ui")
local completion = require("completion")
local editor = require("editor")

lazy.setup{
	spec = {
		-- Pkg Manager
		{ "folke/lazy.nvim", tag = "stable" },

		-- UI
		ui.colorscheme("catppuccin-macchiato"),
		ui.statusline(),
		-- ui.bufferline(),
		ui.breadcrumbs(),
		ui.indentline(),
		ui.whichkey(),
		ui.project(),
		-- ui.colorizer(),
		ui.treesitter(),
		ui.codehighlight(),
		ui.winfocus(),
		ui.surround(),
		-- editor.easyalign(),

		-- Completion
		completion.completion(),
		completion.autopair(),
		completion.lsp(),
		completion.schemas(),
		completion.language_java(),
		completion.language_rust(),
		completion.language_kotlin(),
		completion.language_go(),
		-- completion.language_sql(),
		completion.assistant(),

		-- Editor
		editor.filemanager(),
		editor.telescope(),
		editor.undotree(),
		editor.diagnostic(),
		editor.git(),
		editor.markdown(),
		-- editor.database(),
	},
	ui = { border = "rounded" },
	change_detection = {
		enabled = true,
		notify = false,
	},
}

