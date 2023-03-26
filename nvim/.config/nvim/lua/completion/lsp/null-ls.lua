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

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml", "markdown" },
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
        -- formatting.isort,
		formatting.tidy_import,
		formatting.reorder_python_imports.with({
			extra_args = function()
				local extra_args = {}

				local python_version = vim.fn.system("python --version")

				if python_version >= "3.9" then
					table.insert(extra_args, "--py39-plus")
				elseif python_version >= "3.7" then
					table.insert(extra_args, "--py37-plus")
				elseif python_version >= "3.6" then
					table.insert(extra_args, "--py36-plus")
				elseif python_version >= "3" then
					table.insert(extra_args, "--py3-plus")
				end

				return extra_args
			end,
		}),
		formatting.stylua,
		-- formatting.google_java_format,
		formatting.ktlint,
		-- formatting.astyle.with({
		--     extra_args = { "ident=spaces=4", "style=google" },
		-- }),

		-- diagnostics
		diagnostics.shellcheck,
		diagnostics.zsh,
		diagnostics.flake8.with({
			extra_args = { "--ignore-errorsa=E501" },
		}),
        diagnostics.checkstyle.with({
            extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        }),
        -- diagnostics.pmd.with({
        --     extra_args = {
        --         "--rulesets",
        --         "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
        --     },
        -- }),
        diagnostics.ktlint,
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
end

return M
