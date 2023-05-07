-- Map space as leader key
vim.g.mapleader = " "
vim.g.localleader = "<Space>"
vim.g.maplocalleader = " "

local keymap = vim.api.nvim_set_keymap

-- TODO: Send to Globals
local keybindings = {
	-- {'mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool}}

	-- disable keys
	{ "n", "Q", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<Left>", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<Right>", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<Up>", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<Down>", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<C-z>", "<Nop>", { noremap = true, silent = true } },
	{ "n", "<Space>", "<Nop>", { noremap = true, silent = true } },

	-- Move visual block of code
	{ "v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true } },
	{ "v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true } },

	-- Wrap line above and cursor stay in place
	{ "n", "J", "mzJ`z", { noremap = true, silent = true } },

	-- Movement and center
	{ "n", "<C-d>", "<C-d>zz", { noremap = true, silent = true } },
	{ "n", "<C-u>", "<C-u>zz", { noremap = true, silent = true } },
	{ "n", "n", "nzz", { noremap = true, silent = true } },
	{ "n", "N", "Nzz", { noremap = true, silent = true } },

	-- Cut replacement to void
	{ "x", ",p", '"_dP', { noremap = true, silent = true, desc = "[P]aste without Yanking" } },
	{ "n", ",d", '"_d', { noremap = true, silent = true, desc = "[D]elete without Yanking to the Clipboard" } },
	{ "v", ",d", '"_d', { noremap = true, silent = true, desc = "[D]elete without Yanking to the Clipboard" } },

	-- Yank system and vim separate
	{ "n", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "v", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",Y", [["+Y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",d", [["_d]], { noremap = true, silent = true, desc = "[D]elete Yank to Clipboard" } },

	-- resize window
	{ "n", "<C-Left>", "<CMD>vertical resize +5<CR>", { noremap = true, silent = true } },
	{ "n", "<C-Up>", "<CMD>resize -5<CR>", { noremap = true, silent = true } },
	{ "n", "<C-Right>", "<CMD>vertical resize -5<CR>", { noremap = true, silent = true } },
	{ "n", "<C-Down>", "<CMD>resize +5<CR>", { noremap = true, silent = true } },

    -- Buffer
	{ "n", "<leader>bq", "<CMD>bdelete<CR>", { noremap = true, silent = true, desc = "Close Current Buffer" } },
	{ "n", "<leader>bQ", "<CMD>bdelete!<CR>", { noremap = true, silent = true, desc = "Force Close Current Buffer" } },
	{ "n", "<leader>ba", "<CMD>bd<CR>", { noremap = true, silent = true, desc = "Close All Buffers" } },
	{ "n", "<leader>bc", "<CMD>%bd|e#|bd#<CR>", { noremap = true, silent = true, desc = "Keep Only Current Buffer" } },
	{ "n", "<leader>bC", "<CMD>%bd!|e#|bd#<CR>", { noremap = true, silent = true, desc = "Force Keep Only Current Buffer" } },
	{ "n", "<leader>bm", "<CMD>bmodified<CR>", { noremap = true, silent = true, desc = "Jump to Modified Buffer" } },
    -- TODO: Better keymaps
    { "n", "<A-f>", "<CMD>bnext<CR>", { noremap = true, silent = true } },
    { "n", "<A-g>", "<CMD>bprevious<CR>", { noremap = true, silent = true } },
    { "n", "<A-0>", "<CMD>bfirst<CR>", { noremap = true, silent = true } },
    { "n", "<A-->", "<CMD>blast<CR>", { noremap = true, silent = true } },

    -- TODO: prefer builtin Tabs and Buffer
	-- Bufferline
	-- { "n", "<A-l>", "<CMD>BufferLineCycleNext<CR>", { noremap = true, silent = true } },
	-- { "n", "<A-h>", "<CMD>BufferLineCyclePrev<CR>", { noremap = true, silent = true } },
	{ "n", "<A-L>", "<CMD>BufferLineMoveNext<CR>", { noremap = true, silent = true } },
	{ "n", "<A-H>", "<CMD>BufferLineMovePrev<CR>", { noremap = true, silent = true } },
	{ "n", "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true } },
	{ "n", "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true } },
	{ "n", "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true } },
	{ "n", "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true } },
	{ "n", "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true } },
	{ "n", "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true } },
	{ "n", "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true } },
	{ "n", "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true } },
	{ "n", "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true } },

	-- split window
	-- { "n", "<leader>v", "<C-w>v", { noremap = false, silent = true } },
	-- { "n", "<leader>s", "<C-w>s", { noremap = false, silent = true } },

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
}

-- TODO: define plugin dependent keymaps in separete after file
local _, builtin = pcall(require, "telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find Project Recently Opened Files" })
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<cr>", {silent = true, noremap = true, desc = "Toggle Tree"})
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
end, { desc = "[/] Fuzzily Search Current Buffer" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch Project [F]iles" })
vim.keymap.set("n", "<leader>sG", builtin.git_status, { desc = "[S]earch [G]it Status" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch Neovim [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch Current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch Project by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch Project [D]iagnostics" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [k]eymaps" })
vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [t]reesitter" })
vim.keymap.set("n", "<leader>sT", builtin.builtin, { desc = "[S]earch [T]elescope Builtins" })
vim.keymap.set("n", "<leader>sd", function() require("telescope.builtin").dap() end, { desc = "[S]earch [d]ap" })

-- Format LSP
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end, { noremap = false, silent = true, desc = "[F]ormat Text" })

-- Tmux session
vim.keymap.set("n", "<c-F>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { noremap = false, silent = true })

for _, key in pairs(keybindings) do
	keymap(key[1], key[2], key[3], key[4])
end

-- DAP Globals
local dap_map = function(lhs, rhs, desc)
	if desc then
		desc = "[DAP] " .. desc
	end

	vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

dap_map("<F1>", require("dap").step_back, "step_back")
dap_map("<F2>", require("dap").step_into, "step_into")
dap_map("<F3>", require("dap").step_over, "step_over")
dap_map("<F4>", require("dap").step_out, "step_out")
dap_map("<F5>", require("dap").continue, "continue")
dap_map("<leader>dr", require("dap").repl.open, "REPL")
dap_map("<leader>db", require("dap").toggle_breakpoint, "Toggle [B]reak Point")
dap_map("<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("[DAP] Condition > ")) end, "Set [B]reak Point")
dap_map("<leader>de", require("dapui").eval, "[E]val UI")
dap_map("<leader>dE", function() require("dapui").eval(vim.fn.input("[DAP] Expression > ")) end, "[E]xpression")
dap_map("<leader>do", function() require("dapui").open() end, "[O]pen")
dap_map("<leader>dc", function() require("dapui").close() end, "[C]lose")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo Tree" })

-- Name every Which Key node
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
    local opts = {
        mode = { "n" },
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    }

    wk.register({
        l = { name = "+LSP" },
        d = { name = "+Debug" },
        s = { name = "+Telescope Search" },
        b = { name = "+Buffer" },
    },
        opts
    )
end

vim.cmd([[
        augroup DapRepl
        au!
        au FileType dap-repl lua require('dap.ext.autocompl').attach()
        augroup END
        ]])

-- prevent typo when main interactions ':'
-- vim.cmd([[
-- cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
-- cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
-- cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
-- cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
-- ]])

local abbreviations = {
	Wq = "wq",
	WQ = "wq",
	Wqa = "wqa",
	W = "w",
	Q = "q",
	Qa = "qa",
	Bd = "bd",
	E = "e",
}

for l, r in pairs(abbreviations) do
	vim.cmd.cnoreabbrev(("%s %s"):format(l, r))
end
