local Completion = {}

function Completion.completion()
	return {
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				event = "InsertEnter",
				config = function()
					if vim.g.snippets ~= "luasnip" then
						return
					end
					local ls = require("luasnip")
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
				dependencies = { "rafamadriz/friendly-snippets", event = "InsertEnter" },
			},
			{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
			{ "hrsh7th/cmp-cmdline", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
			{ "onsails/lspkind-nvim", event = "InsertEnter" },
			{ "hrsh7th/cmp-emoji", event = "InsertEnter" },
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("completion.cmp").config()
		end,
	}
end

function Completion.lsp()
	return {
		{
			"neovim/nvim-lspconfig",
			lazy = true,
			dependencies = {
				"mason-lspconfig.nvim",
			},
			config = function()
				require("completion.lsp")
			end,
			after = "mason",
		},
		{
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			event = "BufReadPre",
			config = function()
				require("completion.lsp.mason").config()
			end,
			dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		},
		{
			"williamboman/mason-lspconfig.nvim",
			-- cmd = { "LspInstall", "LspUninstall" },
			dependencies = "mason.nvim",
		},
		{
			"nvimtools/none-ls.nvim",
			event = "BufReadPre",
			dependencies = {
				"nvim-lua/plenary.nvim"
			},
			config = function()
				require("completion.lsp.null-ls").config()
			end,
		},
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			config = function()
				require("fidget").setup({})
			end,
		},
		{
			"folke/neodev.nvim",
			config = function()
				require("neodev").setup()
			end,
		},
	}
end

function Completion.schemas()
	return {
		"b0o/schemastore.nvim",
		event = "VeryLazy",
		config = function()
			require("lspconfig").jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
	}
end

function Completion.language_go()
	return {
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		config = function()
			require("editor.dap_go").setup()
		end,
		dependencies = "mfussenegger/nvim-dap",
		-- TODO: Give this a try
		-- {
		--     "ray-x/go.nvim",
		--     config = function()
		--         require("go").setup()
		--     end,
		--     event = {"CmdlineEnter"},
		--     ft = {"go", 'gomod'},
		--     build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
		-- }
	}
end

function Completion.language_java()
	return {
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		event = "VeryLazy",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" }
		},
	}
end

function Completion.language_kotlin()
	return {
		"udalov/kotlin-vim",
		event = "VeryLazy",
	}
end

function Completion.language_rust()
	return {
		"simrat39/rust-tools.nvim",
		event = "VeryLazy",
		config = function()
			require("rust-tools").setup()
		end,
		-- {
		--     "Saecki/crates.nvim",
		--     config = function() require("crates").setup() end,
		-- },
	}
end

function Completion.language_sql()
    return {
        "nanotee/sqls.nvim",
        ft = "sql",
    }
end

function Completion.assistant()
	return {
		{
			"zbirenbaum/copilot.lua",
			event = { "InsertEnter", "VeryLazy" },
			config = function()
				require("completion.copilot").config()
			end,
			cmd = "Copilot",
			dependencies = {
				{ "zbirenbaum/copilot-cmp" },
			},
		},
		-- { "AndreM222/copilot-lualine" },
	}
end

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
