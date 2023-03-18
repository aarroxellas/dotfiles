local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    vim.notify("cmp_nvim_lsp not loaded", vim.log.levels.WARN, { title = "completion.lsp.handlers" })
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {

        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs, -- show signs
        },
        update_in_insert = true,
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
end

-- TODO: add description to maps
local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts )   --  { desc = "[G]o to [D]eclaration" }
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts )    --  { desc = "[G]o to [D]efinition" }
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)   --  { desc = "Hover Over" }
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) --  { desc = "[G]o to [I]mplementation" }
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) --  { desc = "[R]eferences" }
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)  --  { desc = "Diagnostics" }
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)  --  { desc = "[L]sp [I]nfo for attached servers" }
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)    --  { desc = "[L]naguage [I]nfo for available services" }
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)    --  { desc = "[L]sp Code [A]ction" }
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts) --  { desc = "[G]o to [N]ext Diagnostics" }
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts) --  { desc = "[G]o to [P]revious Diagnostics" }
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts) --  { desc = "[L]sp [R]eaname" }
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) --  { desc = "[L]sp [S]ignature Help" }
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)  -- { desc = "[L]sp" }

    -- TODO: Define keymap
    vim.cmd([[command! Format execute 'lua vim.lsp.buf.format({ async = true })']])
end

-- TODO: to a separate file
M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "kotlin_language_server" then
        client.server_capabilities.documentFormattingProvider = false
    end

    for _, name in pairs({ "pyright", "jedi_language_server" }) do
        if client.name == name then
            client.server_capabilities.documentFormattingProvider = false
        end
    end

    if client.name == "jdt.ls" then
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.dap").setup_dap_main_class_configs()
        client.resolved_capabilities.textDocument.completion.completionItem.snippetSupport = false
        vim.lsp.codelens.refresh()
    end

    for _, name in pairs({ "sumneko_lua", "lua_ls" }) do
        if client.name == name then
            client.server_capabilities.documentFormattingProvider = false
        end
    end

    lsp_keymaps(bufnr)
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        vim.notify("completion.lsp.illuminate not loaded", vim.log.levels.WARN, { title = "completion.lsp.handlers" })
        return
    else
        illuminate.on_attach(client)
    end
end

return M
