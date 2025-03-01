local M = {}

function M.config()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
        vim.notify("completion.lsp.null_ls not loaded", vim.log.levels.WARN, { title = "completion.lsp.null_ls" })
        return
    end

    local h = require("null-ls.helpers")
    local methods = require("null-ls.methods")
    local FORMATTING = methods.internal.FORMATTING

    null_ls.builtins.formatting.tidy_import = h.make_builtin({
        name = "tidy_import",
        meta = {
            url = "https://github.com/deshaw/pyflyby",
            description = "automatic imports for python",
        },
        method = FORMATTING,
        filetypes = { "python" },
        generator_opts = {
            command = "tidy-imports",
            args = {
                "--quiet",
                "--replace-star-imports",
                "--add-missing",
                "--replace",
                "--separate-from-imports",
                "--remove-unused",
                "$FILENAME",
            },
            to_stdin = false,
            to_temp_file = true,
        },
        factory = h.formatter_factory,
    })

    local code_actions = null_ls.builtins.code_actions
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local sources = {
        -- Golang
        -- TODO: Make available for visual selection
        code_actions.gomodifytags,
        diagnostics.golangci_lint,

        -- JS
        formatting.prettier.with({
            extra_filetypes = { "toml", "markdown" },
            -- extra_args = { "--no-semi", "--tab-width 4", "--single-quote", "--jsx-single-quote" },
        }),

        -- Python
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.isort,
        formatting.tidy_import,
        -- diagnostics.flake8.with({
        --     extra_args = { "--ignore=E501" },
        -- }),
        -- formatting.reorder_python_imports,

        -- Lua
        formatting.stylua,

        -- Java
        -- formatting.google_java_format,
        -- diagnostics.checkstyle.with({
        --     extra_args = { "-c", "~/.config/checkstyle/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        -- }),
        -- formatting.astyle.with({
        -- diagnostics.pmd.with({
        --     extra_args = {
        --         "--rulesets",
        --         "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
        --     },
        -- }),
        --     extra_args = { "ident=spaces=4", "style=google" },
        -- }),
        -- Kotlin
        formatting.ktlint,
        diagnostics.ktlint,

        -- Shell
        diagnostics.zsh,
    }

    local ok, _ = pcall(require, "gitsigns")
    if ok then
        table.insert(sources, null_ls.builtins.code_actions.gitsigns)
    else
        vim.notify("gitsigns for null-ls not loaded", vim.log.levels.WARN, { title = "completion.lsp.null-ls" })
    end

    -- TODO: Check for available sources in the system and load then as you go
    null_ls.setup({
        debug = false,
        sources = sources,
    })

    -- Rust
    local unwrap = {
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "rust" },
        generator = {
            fn = function(params)
                local diagnostics = {}
                -- sources have access to a params object
                -- containing info about the current file and editor state
                for i, line in ipairs(params.content) do
                    local col, end_col = line:find "unwrap()"
                    if col and end_col then
                        -- null-ls fills in undefined positions
                        -- and converts source diagnostics into the required format
                        table.insert(diagnostics, {
                            row = i,
                            col = col,
                            end_col = end_col,
                            source = "unwrap",
                            message = "hey " .. os.getenv("USER") .. ", don't forget to handle this" ,
                            severity = 2,
                        })
                    end
                end
                return diagnostics
            end,
        },
    }

    null_ls.register(unwrap)
end

return M
