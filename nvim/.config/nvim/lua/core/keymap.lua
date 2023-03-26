vim.g.mapleader = " "
vim.g.localleader = "<Space>"

local keymap = vim.api.nvim_set_keymap

-- TODO: define keymaps in separete after file
local builtin = require('telescope.builtin')
local keybindings = {
    -- {'mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool}}

    -- disable keys
    { "n", "Q", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<Left>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<Right>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<Up>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<Down>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<C-z>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<Space>", "<Nop>", { noremap = true, silent = true, desc = "Keymap" } },

    -- Move visual block of code
    { "v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Keymap" } },
    { "v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Keymap" } },

    -- Yank system and vim separate
    { "n", "<leader>y", [["+y]], { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<leader>y", [["+y]], { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<leader>Y", [["+Y]], { noremap = true, silent = true, desc = "Keymap" } },
    { "n", "<leader>d", [["_d]], { noremap = true, silent = true, desc = "Keymap" } },

    -- Wrap line above and cursor stay in place
    { "n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Keymap" } },

    -- Cut replacement to void
    { "x", "<leader>p", "\"_dP", { noremap = true, silent = true, desc = "Keymap" } },

    -- resize window
    { "n", "<C-Left>", "<CMD>vertical resize +5<CR>", { noremap = true, silent = true } },
    { "n", "<C-Up>", "<CMD>resize -5<CR>", { noremap = true, silent = true } },
    { "n", "<C-Right>", "<CMD>vertical resize -5<CR>", { noremap = true, silent = true } },
    { "n", "<C-Down>", "<CMD>resize +5<CR>", { noremap = true, silent = true } },

    -- Buffer
    { "n", "<A-l>", "<CMD>BufferNext<CR>", { noremap = true, silent = true } },
    { "n", "<A-h>", "<CMD>BufferPrevious<CR>", { noremap = true, silent = true } },
    { "n", "<A-L>", "<CMD>BufferMoveNext<CR>", { noremap = true, silent = true } },
    { "n", "<A-H>", "<CMD>BufferMovePrevious<CR>", { noremap = true, silent = true } },
    { "n", "<leader>q", "<CMD>BufferClose<CR>", { noremap = true, silent = true, desc = "Close Current Buffer" } },
    { "n", "<leader>qq", "<CMD>bufdo BufferClose<CR>", { noremap = true, silent = true, desc = "Close Current Buffer" } },
    { "n", "<leader>qa", "<CMD>bufdo BufferClose!<CR>", { noremap = true, silent = true, desc = "Force Close Current Buffer" } },
    { "n", "<leader>qo", "<CMD>BufferCloseAllButCurrent<CR>", { noremap = true, silent = true, desc = "Close All Buffers" } },
    { "n", "<A-1>", "<CMD>BufferGoto 1<CR>", { noremap = true, silent = true } },
    { "n", "<A-2>", "<CMD>BufferGoto 2<CR>", { noremap = true, silent = true } },
    { "n", "<A-3>", "<CMD>BufferGoto 3<CR>", { noremap = true, silent = true } },
    { "n", "<A-4>", "<CMD>BufferGoto 4<CR>", { noremap = true, silent = true } },
    { "n", "<A-5>", "<CMD>BufferGoto 5<CR>", { noremap = true, silent = true } },
    { "n", "<A-6>", "<CMD>BufferGoto 6<CR>", { noremap = true, silent = true } },
    { "n", "<A-7>", "<CMD>BufferGoto 7<CR>", { noremap = true, silent = true } },
    { "n", "<A-8>", "<CMD>BufferGoto 8<CR>", { noremap = true, silent = true } },
    { "n", "<A-9>", "<CMD>BufferGoto 9<CR>", { noremap = true, silent = true } },
    { "n", "<A-0>", "<CMD>BufferLast<CR>", { noremap = true, silent = true } },

    -- split window
    { "n", "<leader>v", "<C-w>v", { noremap = false, silent = true, desc = "Slip Window Vertically" } },
    { "n", "<leader>s", "<C-w>s", { noremap = false, silent = true, desc = "Slip Window Horizontally" } },

    -- Move between slits
    { "n", "<c-h>", "<C-w>h", { noremap = false, silent = true } },
    { "n", "<c-j>", "<C-w>j", { noremap = false, silent = true } },
    { "n", "<c-k>", "<C-w>k", { noremap = false, silent = true } },
    { "n", "<c-l>", "<C-w>l", { noremap = false, silent = true } },
    { "n", "<c-h>", "<C-\\><C-n><C-w>h", { noremap = false, silent = true } },
    { "n", "<c-l>", "<C-\\><C-n><C-w>l", { noremap = false, silent = true } },

    -- terminal mode
    { "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true } },

    -- -- base64
    -- {
    --     "v",
    --     "<leader>d6",
    --     "c<C-r>=system('base64 -d', @\")<CR><ESC>",
    --     remap_nosilent,
    -- },
    -- {
    --     "v",
    --     "<leader>e6",
    --     "c<C-r>=system('base64', @\")<CR><ESC>",
    --     remap_nosilent,
    -- },
    --
    -- -- emmet-vim
    -- { "i", "<A-Tab>", "<C-y>,", { noremap = false, silent = true } },
    -- { "v", "<A-Tab>", "<C-y>,", { noremap = false, silent = true } },
    --
    -- -- Delete in search result
    -- { "n", "<leader>x", "<CMD>%s///<CR>", { noremap = false, silent = true, desc = "Keymap" } },
    --
    -- -- Search for visually selected text
    -- { "v", "<leader>v", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { noremap = false, silent = true, desc = "Keymap" } },
    --
    -- format.nvim
    { "n", "<leader>F", "<CMD>FormatWrite<CR>", { noremap = false, silent = true, desc = "Format Text" } },
}

for _, key in pairs(keybindings) do
    keymap(key[1], key[2], key[3], key[4])
end

--Remap space as leader key
vim.cmd([[
let mapleader=" "
]])
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- prevent typo when main interactions ':'
-- vim.cmd([[
-- cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
-- cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
-- cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
-- cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
-- ]])

local abbreviations = {
    Wq = 'wq',
    WQ = 'wq',
    Wqa = 'wqa',
    W = 'w',
    Q = 'q',
    Qa = 'qa',
    Bd = 'bd',
    E = 'e',
}

for l, r in pairs(abbreviations) do
    vim.cmd.cnoreabbrev(("%s %s"):format(l, r))
end
