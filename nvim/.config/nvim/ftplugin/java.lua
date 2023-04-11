local M = {}

function M.keymaps(bufnr)
    -- keymaps LSP
    require("completion.lsp.handlers").lsp_keymaps(bufnr)

    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "<leader>lo", "<cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true, desc = "[O]rganize Imports" })
    keymap(bufnr, "n", "<leader>lC", "<cmd>lua require'jdtls'.compile('full')<CR>", { noremap = true, silent = true, desc = "[C]ompile Full" })
    keymap(bufnr, "n", "<leader>lc", "<cmd>lua require'jdtls'.compile('incremental')<CR>", { noremap = true, silent = true, desc = "[c]ompile Incremental" })
    keymap(bufnr, "n", "gS", "<cmd>lua require'jdtls'.super_implementation()<CR>", { noremap = true, silent = true, desc = "[G]o to Super Implementation" })
    keymap(bufnr, "n", "<leader>dt", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true, desc = "[t]est Nearest Method" })
    keymap(bufnr, "n", "<leader>dT", "<cmd>lua require'jdtls'.test_class()<CR>", { noremap = true, silent = true, desc = "[T]est Class" })
    keymap(bufnr, "n", "<leader>dp", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true, desc = "[p]ick a test" })

    keymap(bufnr, "n", "<leader>lem", "<cmd>lua require'jdtls'.extract_method()<CR>", { noremap = true, silent = true, desc = "[e]xtract [m]ethod" })
    keymap(bufnr, "v", "<leader>lem", "<esc><cmd>lua require'jdtls'.extract_method()<CR>", { noremap = true, silent = true, desc = "[e]xtract [m]ethod" })
    keymap(bufnr, "n", "<leader>lev", "<cmd>lua require'jdtls'.extract_variable()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable" })
    keymap(bufnr, "v", "<leader>lev", "<esc><cmd>lua require'jdtls'.extract_variable()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable" })
    keymap(bufnr, "n", "<leader>leV", "<cmd>lua require'jdtls'.extract_variable_all()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable recurrences" })
    keymap(bufnr, "v", "<leader>leV", "<esc><cmd>lua require'jdtls'.extract_variable_all()<CR>", { noremap = true, silent = true, desc = "[e]xtract [v]ariable recurrences" })
    keymap(bufnr, "n", "<leader>lec", "<cmd>lua require'jdtls'.extract_constant()<CR>", { noremap = true, silent = true, desc = "[e]xtract [c]onstant" })
    keymap(bufnr, "v", "<leader>lec", "<esc><cmd>lua require'jdtls'.extract_constant()<CR>", { noremap = true, silent = true, desc = "[e]xtract [c]onstant" })

    local ok_wk, wk = pcall(require, "which-key")
    if ok_wk then
        local opts = {
            mode = { "n", "v" },
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        }

        wk.register({
            l = {
                e = { name = "[E]xtract" }
            }
        },
            opts
        )
    end
end

function M.setup()
    local jdtls = require("jdtls")
    local jdtls_setup = require("jdtls.setup")
    local bundles_dap = { vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar") }
    local bundles_test = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar")
    -- Determine OS
    local system = "linux"
    if vim.fn.has("mac") == 1 then system = "mac" end

    local config = {
        -- Local jdtls installation
        cmd = { "/usr/local/bin/jdtls",
            "-configuration " .. vim.fn.expand("~/.local/share/jdtls/config_" .. system),
            "-data " .. vim.fn.expand("~/.cache/jdtls-workspace"),
        },

        -- Mason install and config
        -- cmd = {
        -- vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"),
        -- "-configuration " .. vim.fn.stdpath("data") .. vim.fn.expand("~/.cache/jdtls"),
        -- },
        root_dir = jdtls_setup.find_root({'gradlew', '*.gradle', '.git', 'mvnw', '.mvn'}),
        init_options = {
            bundles = vim.list_extend(bundles_dap, vim.split(bundles_test, "\n")),
        },
        settings = {
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            java = {
                implementationsCodeLens = { enabled = true },
                quickfix = { enabled = true },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    }
                },
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-11",
                            path = os.execute("asdf where java adoptopenjdk-11.0.18+10"),
                        },
                        {
                            name = "JavaSE-17",
                            path = os.execute("asdf where java adoptopenjdk-17.0.2+8"),
                        },
                    }
                }
            },
        },
        contentProvider = { preferred = "fernflower" },
        signatureHelp = { enabled = true },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
        flags = {
            allow_incremental_sync = true,
        },
        capabilities = require'lspconfig'.util.default_config.capabilities,
        on_attach = function(client, bufnr)
            pcall(vim.lsp.codelens.refresh)

            jdtls_setup.add_commands()
            jdtls.update_project_config()
            jdtls.setup_dap({ hotcodereplace = 'auto' })
            -- TODO: Set keymaps for buffer not to 0 - current one
            -- M.keymaps(bufnr or 0)
        end,

    }

    jdtls.start_or_attach(config)
end

function M.config()
    M.setup()
    M.keymaps(0)
end

return M.config()
