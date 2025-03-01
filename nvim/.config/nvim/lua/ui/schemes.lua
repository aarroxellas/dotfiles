local M = {}

function M.config(colorscheme)
    vim.opt.termguicolors = true
    vim.cmd([[
        syntax enable
        " set background=dark

       " AYU
        let ayucolor="mirage"
        " 'mirage' | 'dark' | 'light'

        " NORD
        let g:nord_cursor_line_number_background = 1
        let g:nord_bold_vertical_split_line = 1
        let g:nord_uniform_diff_background = 1
        let g:nord_italic_comments = 1

		" Catppuccin
		" catppuccin | catppuccin-latte | catppuccin-frappe | catppuccin-macchiato | catppuccin-mocha

		" Kanagawa
		" kanagawa | kanagawa-wave | kanagawa-dragon | kanagawa-lotus

		" One Dark
		let g:onedark_config = { 'style': 'dark', }
		" dark | carker | cool | deep | warm | warmer

    ]])

    if colorscheme == nil then
        colorscheme = "default"
    end

	if string.match(colorscheme, "catppuccin") then
		require"catppuccin".setup({
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		})
	end

    local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        vim.notify("colorscheme " .. colorscheme .. " not loadded!", vim.log.levels.WARN, { title = "colorscheme.config" })
        return ok
    end

    -- local colorscheme_group = "configusercolorscheme"
    -- vim.api.nvim_create_augroup(colorscheme_group, {})

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- vim.api.nvim_create_autocmd(colorscheme_group, {
    --     callback = function()
    --         vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    --         vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    --         vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
    --         vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
    --     end,
    --     group = colorscheme_group,
    -- })
end

return M
