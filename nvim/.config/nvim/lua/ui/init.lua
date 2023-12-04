local UI = {}

function UI.bufferline()
	return {
		"akinsho/bufferline.nvim",
        version = "v3.*",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("ui.bufferline").config()
		end,
	}
end

function UI.indentline()
	return {
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		main ="ibl",
		config = function()
			require("ui.indentline").config()
		end,
	}
end

function UI.filemanager()
	return {
		"nvim-tree/nvim-tree.lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function ()
		  require("ui.filemanager").config()
		end,
	}
end

function UI.whichkey()
	return {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	}
end

function UI.undotree()
    return {
        "mbbill/undotree",
        config = function () vim.g.loaded_undotree = 1 end
    }
end

function UI.telescope()
	return {
		"nvim-telescope/telescope.nvim",
        version = "0.1.x",
		dependencies = {
			-- "nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-fzy-native.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("ui.telescope").config()
		end,
	}
end

function UI.project()
	return {
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				manual_mode = false,
				show_hidden = false,
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", ".fury", ".editorconfig" },
				detection_methods = { "lsp", "pattern" },
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
                datapath = vim.fn.stdpath("data"),
			})
		end,
		event = "VimEnter",
		cmd = "Telescope projects",
	}
end

function UI.treesitter()
	return {
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				config = function()
					require("ui.treesitter").config()
					require'treesitter-context'.setup{
						max_lines = 1,
					}
				end,
			}
			--   { "p00f/nvim-ts-rainbow" },
			--   { "windwp/nvim-ts-autotag" },
		},
	}
end

function UI.colorizer()
	return {
		"norcalli/nvim-colorizer.lua",
		config = require("ui.colorizer"),
	}
end

function UI.colorscheme(colorscheme)
	return {
		{
			"catppuccin/nvim", name = "catppuccin",
			priority = 1000, lazy = false,
			config = function()
				require("ui.schemes").config(colorscheme)
			end,
		},
		{ "arcticicestudio/nord-vim", priority = 1000, lazy = false },
		{ "rebelot/kanagawa.nvim", priority = 1000, lazy = false },
		{ "ayu-theme/ayu-vim", priority = 1000, lazy = false },
		{ "navarasu/onedark.nvim", priority = 1000, lazy = false },
	}
end

function UI.codehighlight()
	return {
		"RRethy/vim-illuminate",
		config = function()
			require("ui.illuminate").config()
		end,
	}
end

function UI.statusline()
	return {
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("ui.lualine").config()
		end,
	}
end

function UI.winfocus()
    return {
        -- "folke/zen-mode.nvim",
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup {
                context = -1,
                treesitter = true,
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },
            }
        end,
    }
end

return UI
