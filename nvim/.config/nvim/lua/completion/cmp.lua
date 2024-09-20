local icons = require("ui.icons")
local formatting = require("ui.formatting")
local M = {}

function M.config()
    local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    local cmp = require("cmp")

    local luasnip = require 'luasnip'
    require("luasnip.loaders.from_vscode").lazy_load()

    local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
    if not status_cmp_ok then
        vim.notify("cmp not loaded", vim.log.levels.WARN, { title = "completion.cmp" })
        return
    end
    local ConfirmBehavior = cmp_types.ConfirmBehavior
    local SelectBehavior = cmp_types.SelectBehavior
    -- local cmp_window = require "cmp.config.window"
    local cmp_mapping = require "cmp.config.mapping"

    cmp.setup {
        active = true,
        on_config_done = nil,
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
			end,
		},
		completion = {
			---@usage The minimum length of a word to complete on.
			keyword_length = 1,
		},
		mapping = cmp.mapping.preset.insert {
			["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
			["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
			["<C-d>"] = cmp_mapping.scroll_docs(-4),
			["<C-f>"] = cmp_mapping.scroll_docs(4),
			["<C-Space>"] = cmp_mapping(cmp_mapping.complete({}), { "i", "c" }),
			["<CR>"] = cmp_mapping.confirm { select = true },
			["<C-e>"] = cmp_mapping{ i = cmp_mapping.abort(), c = cmp_mapping.close() },
			-- Super Tab
			["<Tab>"] = cmp_mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s", }),
			["<S-Tab>"] = cmp_mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s", }),
			-- Default vim
			["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
			["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
			["<C-y>"] = cmp.mapping( cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}, { "i", "c" }),
		},
        formatting = {
            fields = { "kind", "abbr", "menu" },
            duplicates = {
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            },
            duplicates_default = 0,
            format = function(entry, vim_item)
                local max_width = 20
                if max_width ~= 0 and #vim_item.abbr > max_width then
                    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1)
                end
                vim_item.kind = icons.kind[vim_item.kind]
                vim_item.menu = formatting.source_names[entry.source.name]

                if entry.source.name == "copilot" then
                    vim_item.kind = icons.git.Octoface
                    vim_item.kind_hl_group = "CmpItemKindCopilot"
                end

                if entry.source.name == "crates" then
                    vim_item.kind = icons.misc.Package
                    vim_item.kind_hl_group = "CmpItemKindCrate"
                end

                if entry.source.name == "lab.quick_data" then
                    vim_item.kind = icons.misc.CircuitBoard
                    vim_item.kind_hl_group = "CmpItemKindConstant"
                end

                if entry.source.name == "emoji" then
                    vim_item.kind = icons.misc.Smiley
                    vim_item.kind_hl_group = "CmpItemKindEmoji"
                end

                return vim_item
            end,
        },
        sources = {
            {
                name = "copilot",
                keyword_length = 0,
                max_item_count = 3,
                trigger_characters = {
                    {
                        ".", ":", "(", "'", '"', "[", ",", "#", "*", "@", "|", "=", "-", "{", "/", "\\", "+", "?", " ", -- "\t", "\n",
                    },
                },
            },
            {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                    local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                    if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                        return false
                    end
                    if kind == "Text" then
                        return false
                    end
                    return true
                end,
            },
            { name = "path" },
            { name = "luasnip" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
            { name = "tmux" },
        },
        confirm_opts = {
            behavior = ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
        cmdline = {
            enable = false,
            options = {
                {
                    type = ":",
                    sources = {
                        { name = "path" },
                        { name = "cmdline" },
                    },
                },
                {
                    type = { "/", "?" },
                    sources = {
                        { name = "buffer" },
                    },
                },
            },
        },
    }



end

return M
