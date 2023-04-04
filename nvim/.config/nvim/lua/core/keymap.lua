-- Map space as leader key
vim.g.mapleader = " "
vim.g.localleader = "<Space>"
vim.g.maplocalleader = " "

local keymap = vim.api.nvim_set_keymap

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
	{ "n", "n", "nzzv", { noremap = true, silent = true } },
	{ "n", "N", "Nzzv", { noremap = true, silent = true } },

	-- Cut replacement to void
	{ "x", ",p", '"_dP', { noremap = true, silent = true, desc = "[P]aste without Yanking" } },
	{ "n", ",d", '"_d', { noremap = true, silent = true, desc = "[D]elete without Yanking to the Clipboard" } },
	{ "v", ",d", '"_d', { noremap = true, silent = true, desc = "[D]elete without Yanking to the Clipboard" } },

	-- Yank system and vim separate
	{ "n", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",Y", [["+Y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",d", [["_d]], { noremap = true, silent = true, desc = "[D]elete Yank to Clipboard" } },

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
	{
		"n",
		"<leader>qq",
		"<CMD>bufdo BufferClose<CR>",
		{ noremap = true, silent = true, desc = "Close Current Buffer" },
	},
	{
		"n",
		"<leader>qa",
		"<CMD>bufdo BufferClose!<CR>",
		{ noremap = true, silent = true, desc = "Force Close Current Buffer" },
	},
	{
		"n",
		"<leader>qo",
		"<CMD>BufferCloseAllButCurrent<CR>",
		{ noremap = true, silent = true, desc = "Close All Buffers" },
	},
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
	--
}

-- TODO: set every 2 layer keymap with wichkey for better description
-- TODO: define plugin dependent keymaps in separete after file
local _, builtin = pcall(require, "telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find Project Recently Opened Files" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
end, { desc = "[/] Fuzzily Search Current Buffer" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search [P]roject [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Neovim [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search Current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search [P]roject by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search [P]roject [D]iagnostics" })

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
local map = function(lhs, rhs, desc)
	if desc then
		desc = "[DAP] " .. desc
	end

	vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<F1>", require("dap").step_back, "step_back")
map("<F2>", require("dap").step_into, "step_into")
map("<F3>", require("dap").step_over, "step_over")
map("<F4>", require("dap").step_out, "step_out")
map("<F5>", require("dap").continue, "continue")
-- TODO:
-- disconnect vs. terminate
map("<leader>dr", require("dap").repl.open, "REPL")

map("<leader>db", require("dap").toggle_breakpoint, "Toggle [B]reak Point")
map("<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("[DAP] Condition > "))
end, "Set [B]reak Point")
map("<leader>de", require("dapui").eval, "[E]val UI")
map("<leader>dE", function() require("dapui").eval(vim.fn.input("[DAP] Expression > ")) end, "[DAP] [E]xpression")
map("<leader>dt", require("dap-go").debug_test, "Run [G]o debug")

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
