local Editor = {}

function Editor.aerial()
    return {
        "stevearc/aerial.nvim",
        config = require("editor.aerial"),
    }
end

function Editor.diagnostic()
    return {
	-- "folke/lsp-trouble.nvim",
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
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function() require'nvim-dap-virtual-text'.setup() end,
		},
	},
	{
	    "nvim-neotest/neotest",
	    dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
	    }
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
        ft = { "markdown" },
        config = function() require("editor.markdown").config() end,
    }
end

function Editor.sql()
    return {
        "nanotee/sqls.nvim",
        ft = "sql",
    }
end

function Editor.surround()
    return {
        "ur4ltz/surround.nvim",
        config = function()
            require "surround".setup {
                mappings_style = "surround",  -- "surround, sandwitch"
                map_insert_mode = true,
                prompt = false,
            }
        end,
        dependencies = { "tpope/vim-repeat" },
        -- "machakann/vim-sandwich",
        -- keys = { "sa", "sr", "sd" }, -- sandwitch
        keys = {
            { "cs", mode = { "n", "v" } },
            { "ds", mode = { "n", "v" } },
            { "ys", mode = { "n", "v" } },
            { "s", mode = "v" },
            { "<c-s>", mode = "i" },
        }, -- surround
    }
end

function Editor.easyalign()
    return { "junegunn/vim-easy-align", cmd = "EasyAlign" }
end

return Editor
