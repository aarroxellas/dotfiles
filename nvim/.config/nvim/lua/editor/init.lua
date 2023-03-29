local Editor = {}

function Editor.aerial()
    return {
        "stevearc/aerial.nvim",
        config = require("editor.aerial"),
    }
end

function Editor.diagnostic()
    return {
        -- "folke/lsp-trouble.nvim",
        "rcarriga/nvim-dap-ui",
        config = function()
            require("editor.dap").config_ui()
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            config = function() require("editor.dap").config() end,
            {
                "nvim-telescope/telescope-dap.nvim",
                config = function () require("telescope").load_extension("dap") end,
                dependencies = "mfussenegger/nvim-dap",
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function () require'nvim-dap-virtual-text'.setup() end,
                dependencies = "mfussenegger/nvim-dap",
            },
        },
    }
end

function Editor.diagnostic_kotlin()
end

function Editor.diagnostic_go()
    return {
        "leoluz/nvim-dap-go",
        config = function () require("editor.dap_go").setup() end,
        dependencies = "mfussenegger/nvim-dap",
        -- TODO: Give this a try
        -- {
        --     "ray-x/go.nvim",
        --     config = function()
        --         require("go").setup()
        --     end,
        --     event = {"CmdlineEnter"},
        --     ft = {"go", 'gomod'},
        --     build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        -- }
    }
end

function Editor.gitsigns()
    return {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("editor.gitsigns").config() end,
    }
end

function Editor.comment()
    return {
        "numToStr/Comment.nvim",
        keys = { "gc", "gcc" }, -- "<leader>/" },
        -- keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } }, { "<Space>/", mode = { "n", "v" } } },
        event = "User FileOpened",
        config = function() require('editor.comment').config() end,
        lazy = false,
    }
end

function Editor.markdown()
    return {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        config = function() require("editor.markdown").config() end,
    }
end

function Editor.sql()
    return {
        "nanotee/sqls.nvim",
        ft = "sql",
    }
end

function Editor.surround()
    return {
        "ur4ltz/surround.nvim",
        config = function()
            require "surround".setup { mappings_style = "surround" } -- "surround, sandwitch"
        end,
        -- "machakann/vim-sandwich",
        -- keys = { "sa", "sr", "sd" }, -- sandwitch
        keys = { { "cs", mode = { "n", "v" } }, { "ds", mode = { "n", "v" } }, { "ys", mode = { "n", "v" } }, { "<c-s>", mode = "i" } }, -- surround
    }
end

function Editor.easyalign()
    return { "junegunn/vim-easy-align", cmd = "EasyAlign" }
end

return Editor
