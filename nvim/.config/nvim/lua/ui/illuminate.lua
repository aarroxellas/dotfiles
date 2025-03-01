local M = {}

M.config = function()
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        vim.notify("ui.illuminate not loaded", vim.log.levels.WARN, { title = "ui.illuminate" })
        return
    end

    local opts = {
        options = {
            -- providers: provider used to get references in the buffer, ordered by priority
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            -- delay: delay in milliseconds
            delay = 120,
            -- filetype_overrides: filetype specific overrides.
            -- The keys are strings to represent the filetype while the values are tables that
            -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
            filetype_overrides = {},
            -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
            filetypes_denylist = {
                "dirvish",
                "fugitive",
                "alpha",
                "NvimTree",
                "lazy",
                "neogitstatus",
                "Trouble",
                "lir",
                "Outline",
                "spectre_panel",
                "toggleterm",
                "DressingSelect",
                "TelescopePrompt",
            },
            -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
            filetypes_allowlist = {},
            -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
            modes_denylist = {},
            -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
            modes_allowlist = {},
            -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_denylist = {},
            -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_allowlist = {},
            -- under_cursor: whether or not to illuminate under the cursor
            under_cursor = true,
                -- If nil, vim-illuminate will be disabled for large files.
            large_file_overrides = nil,
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = nil,
        },
    }
    vim.schedule_wrap(illuminate.configure(opts))

    -- vim.cmd([[
    --     augroup illuminate_augroup
    --     autocmd!
    --     autocmd VimEnter * hi link illuminatedWord CursorLine
    --     augroup END

    --     augroup illuminate_augroup
    --     autocmd!
    --     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
    --     augroup END
    --     end
    -- ]])
end

return M
