local keymap = vim.api.nvim_set_keymap

-- TODO: cr from inside tab select
local noremap_silent = { noremap = true, silent = true }
local noremap_nosilent = { noremap = true, silent = false }
local remap_silent = { noremap = false, silent = true }
local remap_nosilent = { noremap = false, silent = true }
local keybindings = {
    -- {'mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool}}

    -- disable keys
    { "n", "Q", "<Nop>", noremap_silent },
    { "n", "<Left>", "<Nop>", noremap_silent },
    { "n", "<Right>", "<Nop>", noremap_silent },
    { "n", "<Up>", "<Nop>", noremap_silent },
    { "n", "<Down>", "<Nop>", noremap_silent },
    { "n", "<C-z>", "<Nop>", noremap_silent },
    { "n", "<Space>", "<Nop>", noremap_silent },

    -- resize window
    { "n", "<C-Left>", "<CMD>vertical resize +5<CR>", noremap_silent },
    { "n", "<C-Up>", "<CMD>resize -5<CR>", noremap_silent },
    { "n", "<C-Right>", "<CMD>vertical resize -5<CR>", noremap_silent },
    { "n", "<C-Down>", "<CMD>resize +5<CR>", noremap_silent },

    -- Buffer
    { "n", "<A-l>", "<CMD>BufferNext<CR>", noremap_silent },
    { "n", "<A-h>", "<CMD>BufferPrevious<CR>", noremap_silent },
    { "n", "<A-L>", "<CMD>BufferMoveNext<CR>", noremap_silent },
    { "n", "<A-H>", "<CMD>BufferMovePrevious<CR>", noremap_silent },
    { "n", "<Leader>q", "<CMD>BufferClose<CR>", noremap_silent },
    { "n", "<Leader>qq", "<CMD>bufdo BufferClose<CR>", noremap_silent },
    { "n", "<Leader>qa", "<CMD>bufdo BufferClose!<CR>", noremap_silent },
    { "n", "<Leader>qo", "<CMD>BufferCloseAllButCurrent<CR>", noremap_silent },
    { "n", "<A-1>", "<CMD>BufferGoto 1<CR>", noremap_silent },
    { "n", "<A-2>", "<CMD>BufferGoto 2<CR>", noremap_silent },
    { "n", "<A-3>", "<CMD>BufferGoto 3<CR>", noremap_silent },
    { "n", "<A-4>", "<CMD>BufferGoto 4<CR>", noremap_silent },
    { "n", "<A-5>", "<CMD>BufferGoto 5<CR>", noremap_silent },
    { "n", "<A-6>", "<CMD>BufferGoto 6<CR>", noremap_silent },
    { "n", "<A-7>", "<CMD>BufferGoto 7<CR>", noremap_silent },
    { "n", "<A-8>", "<CMD>BufferGoto 8<CR>", noremap_silent },
    { "n", "<A-9>", "<CMD>BufferGoto 9<CR>", noremap_silent },
    { "n", "<A-0>", "<CMD>BufferLast<CR>", noremap_silent },

    -- split window
    -- { "n", "<Leader>wv", "<C-w>v", remap_silent },
    -- { "n", "<Leader>ws", "<C-w>s", remap_silent },

    -- Move between slits
    { "n", "<c-h>", "<C-w>h", remap_silent },
    { "n", "<c-j>", "<C-w>j", remap_silent },
    { "n", "<c-k>", "<C-w>k", remap_silent },
    { "n", "<c-l>", "<C-w>l", remap_silent },
    { "n", "<c-h>", "<C-\\><C-n><C-w>h", remap_silent },
    { "n", "<c-l>", "<C-\\><C-n><C-w>l", remap_silent },

    -- terminal mode
    { "t", "<Esc>", "<C-\\><C-n>", noremap_silent },

    -- -- nvim tree.lua
    -- { "n", "`", '<CMD>lua require("utils.nvimtree").toggle()<CR>', noremap_silent },
    --
    -- -- telescope
    -- {
    --     "n",
    --     "<Leader><space>",
    --     '<CMD>lua require("telescope.builtin").oldfiles({file_ignore_patterns = {"/usr/share/nvim/runtime/*"}, previewer = false})<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>b",
    --     '<CMD>lua require("telescope.builtin").buffers()<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>o",
    --     '<CMD>lua require("telescope.builtin").find_files({previewer = false})<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>m",
    --     '<cmd>lua require("telescope.builtin").marks()<cr>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader><Leader>",
    --     '<CMD>lua require("telescope.builtin").builtin({previewer = false})<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>k",
    --     '<CMD>lua require("telescope.builtin").keymaps()<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>/",
    --     '<CMD>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>?",
    --     '<CMD>lua require("telescope.builtin").grep_string()<CR>',
    --     noremap_nosilent,
    -- },
    -- {
    --     "n",
    --     "<Leader>c",
    --     '<CMD>lua require("telescope.builtin").commands()<CR>',
    --     noremap_nosilent,
    -- },
    --
    -- -- base64
    -- {
    --     "v",
    --     "<Leader>d6",
    --     "c<C-r>=system('base64 -d', @\")<CR><ESC>",
    --     remap_nosilent,
    -- },
    -- {
    --     "v",
    --     "<Leader>e6",
    --     "c<C-r>=system('base64', @\")<CR><ESC>",
    --     remap_nosilent,
    -- },
    --
    -- -- emmet-vim
    -- { "i", "<A-Tab>", "<C-y>,", remap_silent },
    -- { "v", "<A-Tab>", "<C-y>,", remap_silent },
    --
    -- -- Delete in search result
    -- { "n", "<Leader>x", "<CMD>%s///<CR>", remap_silent },
    --
    -- -- Search for visually selected text
    -- { "v", "<Leader>v", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", remap_silent },
    --
    -- -- format.nvim
    -- { "n", "<leader>F", "<CMD>FormatWrite<CR>", remap_silent },
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
