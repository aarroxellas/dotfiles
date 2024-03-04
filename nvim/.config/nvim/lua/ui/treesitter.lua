local M = {}

function M.config()
	local opts = {
		-- Automatically install missing parsers when entering buffer
		auto_install = true,

		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"go",
			"java",
			"kotlin",
			"lua",
			"python",
			"rust",
			"sql",
			"regex",
			"markdown",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				if vim.tbl_contains({ "latex" }, lang) then
					return true
				end

				local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
				return status_ok and big_file_detected
			end,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
			config = {
				-- Languages that have a single comment style
				typescript = "// %s",
				css = "/* %s */",
				scss = "/* %s */",
				html = "<!-- %s -->",
				svelte = "<!-- %s -->",
				vue = "<!-- %s -->",
				json = "",
			},
		},
		indent = { enable = true, disable = { "yaml", "python", "c", "cpp" } },
		-- textsubjects = {
		-- 	enable = false,
		-- 	keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
		-- },
		-- playground = {
		-- 	enable = false,
		-- 	disable = {},
		-- 	updatetime = 25,                -- Debounced time for highlighting nodes in the playground from source code
		-- 	persist_queries = false,        -- Whether the query persists across vim sessions
		-- 	keybindings = {
		-- 		toggle_query_editor = "o",
		-- 		toggle_hl_groups = "i",
		-- 		toggle_injected_languages = "t",
		-- 		toggle_anonymous_nodes = "a",
		-- 		toggle_language_display = "I",
		-- 		focus_language = "f",
		-- 		unfocus_language = "F",
		-- 		update = "R",
		-- 		goto_node = "<cr>",
		-- 		show_help = "?",
		-- 	},
		-- },
		-- windwp/nvim-ts-autotag
		-- autotag = { enable = false },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<c-backspace>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["ii"] = "@conditional.inner",
					["ai"] = "@conditional.outer",
					["il"] = "@loop.inner",
					["al"] = "@loop.outer",
					["at"] = "@comment.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
				-- goto_next = {
				--   [']i'] = "@conditional.inner",
				-- },
				-- goto_previous = {
				--   ['[i'] = "@conditional.inner",
				-- }
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>n"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>N"] = "@parameter.inner",
				},
			},
		},
		-- p00f/nvim-ts-rainbow
		rainbow = {
			enable = false,
			extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
			max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
		},
		-- windwp/nvim-autopairs
		autopairs = {
			enable = true,
		},
	}

	require("nvim-treesitter.configs").setup(opts)
	-- Not Working: Recover highlighting groups
	-- From: https://github.com/nvim-treesitter/nvim-treesitter/commit/42ab95d5e11f247c6f0c8f5181b02e816caa4a4f#comments
end

return M
