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
    -- TODO: deprecate Diagnostics as leader + l{}
    -- keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { noremap = true, silent = true, desc = "[G]o to [N]ext Diagnostics" })
    -- keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { noremap = true, silent = true, desc = "[G]o to [P]revious Diagnostics" })
    keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { noremap = true, silent = true, desc = "Next [D]iagnostic" })
    keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { noremap = true, silent = true, desc = "Previous [D]iagnostic" })
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = "[L]sp [R]eaname" })
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true, desc = "[L]sp [S]ignature Help" })
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true, desc = "Display Diagnostics Local [L]ist" })

    -- TODO: Define keymap
    vim.cmd([[command! Format execute 'lua vim.lsp.buf.format({ async = true })']])
end

-- TODO: to a separate file
M.on_attach = function(client, bufnr)
    local no_formatting = {
        "tsserver", "pyright", "jedi_language_server", "kotlin_language_server", "sumneko_lua", "lua_ls", "rust_analyzer"
    }

    for _, name in pairs(no_formatting) do
        if client.name == name then
            client.server_capabilities.documentFormattingProvider = false
        end
    end

   --      if server == "rust_analyzer" then
			-- print(server)
   --          local rust_opts = require "completion.lsp.settings.rust"
   --          local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
   --          if not rust_tools_status_ok then
   --              vim.notify("completion.lsp.rust-tools not loaded", vim.log.levels.WARN, { title = "completion.lsp.completion.rust" })
   --              return
   --          end

   --          rust_tools.setup(table.merge(rust_opts, {server = {on_attach = on_attach, capabilities = capabilities}}))

   --          -- TODO: rethink keymapping
   --          -- require("completion.lsp.handlers").lsp_keymaps(0)
   --          goto continue
   --      end

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
