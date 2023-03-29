local Completion = {}

function Completion.snippet()
	return {
		{
			"L3MON4D3/LuaSnip",
			config = function()
				if vim.g.snippets ~= "luasnip" then
					return
				end
				local ls = require("luasnip")
				local types = require("luasnip.utils.types")
				ls.config.set_config({
					history = true,
					updateevents = "TextChanged,TextChangedI",
					enable_autosnippets = true,
				})
				local paths = {}
				require("luasnip.loaders.from_lua").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = paths,
				})
				-- require("luasnip.loaders.from_snipmate").lazy_load()
			end,
			event = "InsertEnter",
			dependencies = { "rafamadriz/friendly-snippets" },
		},
	}
end

function Completion.cmp()
	return {
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{ "L3MON4D3/LuaSnip" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-nvim-lsp" },
				-- { "hrsh7th/cmp-cmdline" },
				{ "hrsh7th/cmp-nvim-lua" },
				-- { "onsails/lspkind-nvim" },
			},
			event = { "InsertEnter", "CmdlineEnter" },
			config = function() require("completion.cmp").config() end,
		},
	}
end

function Completion.lsp()
	return {
		{
			"neovim/nvim-lspconfig",
			lazy = true,
			dependencies = {
				"mason-lspconfig.nvim",
				"nlsp-settings.nvim",
				{
					"folke/neodev.nvim",
					config = function() require("neodev").setup() end,
				},
			},
            config = function () require("completion.lsp") end,
            after = "mason",
		},
		{
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			event = "BufReadPre",
			config = function()
				require("completion.lsp.mason")
			end,
			dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		},
		{
			"tamago324/nlsp-settings.nvim",
			dependencies = "neovim/nvim-lspconfig",
			cmd = "LspSettings",
            config = function ()
                require("nlspsettings").setup({
                    config_home = vim.fn.stdpath('config') .. '/lua/completion/lsp/settings',
                    local_settings_root_markers_fallback = { '.git' },
                    append_default_schemas = true,
                    loader = 'json',
                })
            end
		},
		{
			"williamboman/mason-lspconfig.nvim",
			-- cmd = { "LspInstall", "LspUninstall" },
			dependencies = "mason.nvim",
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			event = "BufReadPre",
			config = function() require("completion.lsp.null-ls").config() end,
		},
        {
            "j-hui/fidget.nvim",
            config = function () require"fidget".setup{} end,
        }
	}
end

function Completion.languages()
    return {
        "udalov/kotlin-vim",
        {
            "simrat39/rust-tools.nvim",
            config = function () require("rust-tools").setup({}) end,
        },
        {
            "Saecki/crates.nvim",
            config = function() require("crates").setup() end,
        },
    }
end

-- function Completion.emmet()
--     return {
--         "mattn/emmet-vim"
--         ft = { "javascript", "html", "css", "scss", "sass" },
--     }
-- end

function Completion.autopair()
	return {
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("completion.autopairs").config()
			end,
			dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
		},
	}
end

return Completion
