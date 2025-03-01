local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    vim.notify("cmp_nvim_lsp not loaded", vim.log.levels.WARN, { title = "completion.lsp.handlers" })
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = { "documentation", "detail", "additionalTextEdits", }
-- }
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()

    local config = {
		signs = {
            active = signs,
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn",  text = "" },
			{ name = "DiagnosticSignHint",  text = "" },
			{ name = "DiagnosticSignInfo",  text = "" },
		},
        virtual_text = false, -- disable virtual text
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    for _, sign in ipairs(config.signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
end

-- TODO: add description to maps
-- TODO: Move to global def.
M.lsp_keymaps = function(bufnr)
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true, desc = "[G]o to [D]eclaration" })
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",  { noremap = true, silent = true, desc = "[G]o to [D]efinition" }) keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Hover Over" })
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true, desc = "[G]o to [I]mplementation" })
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true, desc = "[R]eferences" })
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true, desc = "Diagnostics" })
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "[L]sp [I]nfo for attached servers" })
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", { noremap = true, silent = true, desc = "[L]anguage [I]nfo for available services" })
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, silent = true, desc = "[L]sp Code [A]ction" })
    keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=" .. bufnr .. "})<cr>", { noremap = true, silent = true, desc = "Next [D]iagnostic" })
    keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { noremap = true, silent = true, desc = "Previous [D]iagnostic" })
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = "[L]sp [R]eaname" })
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true, desc = "[L]sp [S]ignature Help" })
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true, desc = "Display Diagnostics Local [L]ist" })

	vim.cmd([[command! Format execute 'lua vim.lsp.buf.format({ async = true })']])
end

M.on_attach = function(client, bufnr)
	local no_formatting = {
		"ts_ls", "pyright", "jedi_language_server", "kotlin_language_server", "lua_ls"
    }

    for _, name in pairs(no_formatting) do
        if client.name == name then
            client.server_capabilities.documentFormattingProvider = false
        end
    end

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        vim.notify("completion.lsp.illuminate not loaded", vim.log.levels.WARN, { title = "completion.lsp.handlers" })
        return
    else
        illuminate.on_attach(client)
    end

    M.lsp_keymaps(bufnr)
end

return M
