local M = {}

function M.config()
    local ok_telescope, telescope = pcall(require, "telescope")
    if not ok_telescope then
        vim.notify("ui.telescope not loaded", vim.log.levels.WARN, { title = "ui.telescope" })
        return
    end

    local ok_telescope_actions, actions = pcall(require, "telescope.actions")
    if not ok_telescope_actions then
        vim.notify("ui.telescope_actions not loaded", vim.log.levels.WARN, { title = "ui.telescope" })
        return
    end

    telescope.setup({
        theme = "dropdown", ---@type telescope_themes
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
            prompt_prefix = "❱ ",
            selection_caret = "❱ ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = nil, -- "descending"
            layout_strategy = nil, -- "flex"
            layout_config = {
                horizontal = {
                    mirror = false,
                    height = 0.7,
                },
                vertical = {
                    mirror = false,
                    height = 0.7,
                },
            },
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-c>"] = actions.close,
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                    ["<C-q>"] = function(...)
                        actions.smart_send_to_qflist(...)
                        actions.open_qflist(...)
                    end,
                    ["<CR>"] = actions.select_default,
                },
                n = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-q>"] = function(...)
                        actions.smart_send_to_qflist(...)
                        actions.open_qflist(...)
                    end,
                },
            },
            file_ignore_patterns = { ".git/", "node_modules" },
            path_display = { "smart" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            color_devicons = true,
            use_less = false,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default { },
        },
        pickers = {
            find_files = {
                hidden = true,
            },
            live_grep = {
                --@usage don't include the filename in the search results
                only_sort_text = true,
            },
            grep_string = {
                only_sort_text = true,
            },
            buffers = {
                initial_mode = "normal",
                mappings = {
                    i = {
                        ["<C-d>"] = actions.delete_buffer,
                    },
                    n = {
                        ["dd"] = actions.delete_buffer,
                    },
                },
            },
            planets = {
                show_pluto = true,
                show_moon = true,
            },
            git_files = {
                hidden = true,
                show_untracked = true,
            },
            colorscheme = {
                enable_preview = true,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- "ignore_case", "respect_case"
            },
        },
    })
end

function M.setup()
    M.config()

    local previewers = require "telescope.previewers"
    local sorters = require "telescope.sorters"

    local tel_setup = {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
    }

    local telescope = require "telescope"

    telescope.setup(tel_setup)

    -- local ok, _ = pcall(require("telescope").load_extension("fzf"))
    -- if not ok then
    --     vim.notify("telescope fzf not  loaded", vim.log.levels.WARN, { title = "ui.telescope" })
    -- end

    -- TODO: Fix project integration
    -- telescope.load_extension "projects"
    -- telescope.extensions.projects.projects{}
end

return M