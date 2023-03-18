local M = {}

function M.config()
    local ok, _ = pcall(require,"indent_blankline")
    if not ok then
        vim.notify("ui.indent_blankline not loaded", vim.log.levels.WARN, { title = "ui.indent_blankline" })
        return
    end

    local opts = {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
    }

    vim.g.indent_blankline_char = "│"
    -- vim.g.indentLine_char_list = { '|', '¦', '┆', '┊' } -- each indent level has a distinct character.
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_filetype_exclude = {
        "NvimTree",
        "Preview",
        "__doc__",
        "dashboard",
        "dashpreview",
        "fzf",
        "help",
        "log",
        "man",
        "markdown",
        "nerdtree",
        "peekaboo",
        "sagahover",
        "startify",
        "terminal",
        "translator",
        "vista",
        "packer",
        "aerial",
        "lspinfo",
        "lspsagafinder",
        "Trouble",
    }
    vim.g.indent_blankline_buftype_exclude = { "terminal", "man", "trouble" }
    -- vim.opt.list = true
    -- vim.opt.listchars = "eol:↴"

    require("indent_blankline").setup(opts)
end

return M
