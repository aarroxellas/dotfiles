-- Map space as leader key
vim.g.mapleader = " "
vim.g.localleader = "<Space>"
vim.g.maplocalleader = " "

local keymap = vim.api.nvim_set_keymap

-- TODO: Send to WhichKey
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
	{ "n", "n", "nzz", { noremap = true, silent = true } },
	{ "n", "N", "Nzz", { noremap = true, silent = true } },
	{ "n", "*", "*zz", { noremap = true, silent = true } },
	{ "n", "#", "#zz", { noremap = true, silent = true } },
	{ "n", "g*", "g*zz", { noremap = true, silent = true } },
	{ "n", "g#", "g#zz", { noremap = true, silent = true } },
	{ "n", "<C-d>", "<C-d>zz", { noremap = true, silent = true } },
	{ "n", "<C-u>", "<C-u>zz", { noremap = true, silent = true } },
	{ "n", "<s-h>", "^", { noremap = true, silent = true, desc = "Jump to the beginning of paragraph" } },
	{ "o", "<s-h>", "^", { noremap = true, silent = true, desc = "Jump to the beginning of paragraph" } },
	{ "x", "<s-h>", "^", { noremap = true, silent = true, desc = "Jump to the beginning of paragraph" } },
	{ "n", "<s-l>", "g_", { noremap = true, silent = true, desc = "Jump to the end of paragraph" } },
	{ "o", "<s-l>", "g_", { noremap = true, silent = true, desc = "Jump to the end of paragraph" } },
	{ "x", "<s-l>", "g_", { noremap = true, silent = true, desc = "Jump to the end of paragraph" } },

	-- Stay in indent mode
	{ "n", "<", "<gv", { noremap = true, silent = true } },
	{ "n", ">", ">gv", { noremap = true, silent = true } },

	-- Cut replacement to void
	{ "x", ",p", [["_dP]], { noremap = true, silent = true, desc = "[P]aste without Yanking to the Registry" } },
	{ "n", ",d", [["_d]], { noremap = true, silent = true, desc = "[D]elete without Yanking to the Registry" } },
	{ "v", ",d", [["_d]], { noremap = true, silent = true, desc = "[D]elete without Yanking to the Registry" } },

	-- Yank system and vim separate
	{ "n", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "v", ",y", [["+y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",Y", [["+Y]], { noremap = true, silent = true, desc = "[Y]ank to Clipboard" } },
	{ "n", ",d", [["_d]], { noremap = true, silent = true, desc = "[D]elete Yank to Clipboard" } },

	-- resize window
	{ "n", "<A-l>", "<CMD>vertical resize +5<CR>", { noremap = true, silent = true } },
	{ "n", "<A-j>", "<CMD>resize -5<CR>", { noremap = true, silent = true } },
	{ "n", "<A-h>", "<CMD>vertical resize -5<CR>", { noremap = true, silent = true } },
	{ "n", "<A-k>", "<CMD>resize +5<CR>", { noremap = true, silent = true } },

    -- Buffer
	{ "n", "<leader>bq", "<CMD>bdelete<CR>", { noremap = true, silent = true, desc = "Close Current Buffer" } },
	{ "n", "<leader>bQ", "<CMD>bdelete!<CR>", { noremap = true, silent = true, desc = "Force Close Current Buffer" } },
	{ "n", "<leader>ba", "<CMD>bd<CR>", { noremap = true, silent = true, desc = "Close All Buffers" } },
	{ "n", "<leader>bc", "<CMD>%bd|e#|bd#<CR>", { noremap = true, silent = true, desc = "Keep Only Current Buffer" } },
	{ "n", "<leader>bC", "<CMD>%bd!|e#|bd#<CR>", { noremap = true, silent = true, desc = "Force Keep Only Current Buffer" } },
	{ "n", "<leader>bm", "<CMD>bmodified<CR>", { noremap = true, silent = true, desc = "Jump to Modified Buffer" } },
	{ "n", "<leader>bn", "<CMD>bnext<CR>", { noremap = true, silent = true, desc = "Jump to Next Buffer" } },
	{ "n", "<leader>bp", "<CMD>bprevious<CR>", { noremap = true, silent = true, desc = "Jump to Previous Buffer" } },

	-- Window Management
	{ "n", "<leader>q", "<CMD>q<CR>", { desc = "Exit Vim." } },
	{ "n", "<leader>Q", "<CMD>q!<CR>", { desc = "Exit Vim!" } },
	{ "n", "<leader>a", "<CMD>qa!<CR>", { desc = "Exit All Vim." } },
	{ "n", "<leader>A", "<CMD>qa!<CR>", { desc = "Exit All Vim!" } },
	{ "n", "<leader>w", "<CMD>w<CR>", { desc = "Save File" } },
	{ "n", "<leader>W", "<CMD>wa<CR>", { desc = "Save All Files" } },

    -- TODO: Better keymaps
    { "n", "<A-f>", "<CMD>bnext<CR>", { noremap = true, silent = true } },
    { "n", "<A-g>", "<CMD>bprevious<CR>", { noremap = true, silent = true } },
    { "n", "<A-0>", "<CMD>bfirst<CR>", { noremap = true, silent = true } },
    { "n", "<A-->", "<CMD>blast<CR>", { noremap = true, silent = true } },

	-- split window
	-- { "n", "<leader>v", "<C-w>v", { noremap = false, silent = true } },
	-- { "n", "<leader>s", "<C-w>s", { noremap = false, silent = true } },

	-- Move between splits
	{ "n", "<c-h>", "<C-w>h", { noremap = false, silent = true } },
	{ "n", "<c-j>", "<C-w>j", { noremap = false, silent = true } },
	{ "n", "<c-k>", "<C-w>k", { noremap = false, silent = true } },
	{ "n", "<c-l>", "<C-w>l", { noremap = false, silent = true } },
	{ "n", "<c-tab>", "<C-6>l", { noremap = false, silent = true } },
	{ "n", "<c-h>", "<C-\\><C-n><C-w>h", { noremap = false, silent = true } },
	{ "n", "<c-l>", "<C-\\><C-n><C-w>l", { noremap = false, silent = true } },

	-- Misc
	{ "n", "<leader>e", ":NvimTreeToggle<cr>", {silent = true, noremap = true, desc = "Toggle Tree"} },
	{ "t", "<C-;>", "<C-\\><C-n>", {silent = true, noremap = true, desc = "escape to normal in terminal"} },
	-- terminal mode
	-- { "n", "<leader>;", "<CMD>terminal<CR> <s-a>", { noremap = true, silent = true, desc = "Go to terminal" } },
	-- { "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true } },

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

	-- Misc
	{ "n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", { noremap = true, silent = true, desc = "(un)wrap" } },
}


-- TODO: define plugin dependent keymaps in separete after file
local ok_tele, builtin = pcall(require, "telescope.builtin")
if ok_tele then
	vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find Project Recently Opened Files" })
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
	vim.keymap.set("n", "<leader>sD", function() builtin.dap() end, { desc = "[S]earch [d]ap" })
end

-- Misc

-- Format LSP
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { noremap = false, silent = true, desc = "[F]ormat Text" })

-- Tmux session
vim.keymap.set("n", "<c-F>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { noremap = false, silent = true })

for _, key in pairs(keybindings) do
	keymap(key[1], key[2], key[3], key[4])
end

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo Tree" })

-- Name every Which Key node
vim.api.nvim_create_autocmd("FileType",
{
	pattern = "*",
	callback = function(ev)
		local ok_wk, wk = pcall(require, "which-key")
		if ok_wk then
			wk.add({
				{ "<leader>b", group = "Buffer", nowait = true, remap = false },
				{ "<leader>d", group = "Debug", nowait = true, remap = false },
				{ "<leader>g", group = "Git", nowait = true, remap = false },
				{ "<leader>l", group = "LSP", nowait = true, remap = false },
				{ "<leader>s", group = "Telescope Search", nowait = true, remap = false },
			})
		end
	end,
	group = vim.api.nvim_create_augroup("which-key-augroup", { clear = true }),
})

-- prevent typo when exec cmd interactions ':'
local typo_safe = {
	Wq = "w<bar>bd",
	WQ = "w<bar>bd",
	Wqa = "waq",
	W = "w",
	Q = "q",
	Qa = "qa",
	Bd = "bd",
	E = "e",
}

for k, v in pairs(typo_safe) do
	vim.api.nvim_create_user_command(("%s"):format(k), ("%s"):format(v), {})
end
