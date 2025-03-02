local Editor = {}

function Editor.filemanager()
	return {
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function ()
		  require("editor.filemanager").config()
		end,
	}
end

function Editor.undotree()
    return {
        "mbbill/undotree",
        config = function () vim.g.loaded_undotree = 1 end
    }
end

function Editor.telescope()
	return {
		"nvim-telescope/telescope.nvim",
        branch = "0.1.x",
		dependencies = {
			-- "nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-smart-history.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("editor.telescope").config()
		end,
	}
end

function Editor.diagnostic()
	return {
		{
			"rcarriga/nvim-dap-ui",
			config = function() require("editor.dap").config_ui() end,
			dependencies =
			{
				"mfussenegger/nvim-dap",
				config = function() require("editor.dap").config() end,
			},
			{
				"nvim-telescope/telescope-dap.nvim",
				config = function() require("telescope").load_extension("dap") end,
				dependencies = {
					"mfussenegger/nvim-dap"
				}
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function() require("nvim-dap-virtual-text").setup({}) end,
			},
		},
		{
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-treesitter/nvim-treesitter",
				-- "vim-test/vim-test" ,
				"nvim-neotest/neotest-vim-test" ,
				"rcasia/neotest-java" ,
				"nvim-neotest/neotest-go" ,
				"nvim-neotest/neotest-python" ,
				"nvim-neotest/neotest-plenary" ,
			},
			config = function()
				require("editor.neotest").config()
			end,
		}
	}
end

function Editor.git()
    return {
	{
	    "lewis6991/gitsigns.nvim",
	    dependencies = { "nvim-lua/plenary.nvim", "tpope/vim-fugitive" },
	    config = function() require("editor.gitsigns").config() end,
	},
    }
end

function Editor.comment()
    return {
        "numToStr/Comment.nvim",
        keys = { "gc", "gcc" }, -- "<leader>/" },
        -- keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } }, { "<Space>/", mode = { "n", "v" } } },
        event = "User FileOpened",
        config = function() require('editor.comment').config() end,
        lazy = false,
    }
end

function Editor.markdown()
    return {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        config = function() require("editor.markdown").config() end,
    }
end

function Editor.easyalign()
    return { "junegunn/vim-easy-align", cmd = "EasyAlign" }
end

function Editor.database()
	return {
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-completion",
		"kristijanhusak/vim-dadbod-ui",
	}
end

return Editor
