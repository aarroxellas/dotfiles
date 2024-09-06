local M = {}

function M.config()
	local options = {
		-- signs = {
		-- 	add = { hl = "GitSignAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		-- 	change = { hl = "GitSignChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		-- 	delete = { hl = "GitSignDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		-- 	topdelete = { hl = "GitSignDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		-- 	changedelete = { hl = "GitSignChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn", },
		-- },
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Add signs in the signcolumn
		numhl = false, -- Highlights just the number part of the number column
		linehl = false, -- Highlights the whole line
		word_diff = false, -- Highlights just the part of the line that has changed
		show_deleted = false, -- Show deleted hunks with virtual text
		watch_gitdir = { -- Add a watcher for the .git directory to detect changes
			enable = true, -- Whether the watcher is enabled
			interval = 2000, -- Interval to wait before polling gitdir in (ms)
			follow_files = true, -- Follow files e.g. git mv
		},
		attach_to_untracked = true, -- Attach to untracked files
		current_line_blame = false, -- Add current line blame
		current_line_blame_opts = { -- Options for lineblame
			virt_text = true, -- Whether to show virtual_text for line blame
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 2000, -- Delay before line blame is shown
			ignore_whitespace = false, -- Ignore whitespaces
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>", -- Line blame formatter
		sign_priority = 6, -- Sign priority
		update_debounce = 100, -- Debounce time for updates in (ms)
		status_formatter = nil, -- Use default status_formatter
		max_file_length = 40000, -- Max file length to attach to
		preview_config = { -- Options to pass to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Next Git Diff previous Hunk"})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Previous Git Diff next Hunk"})

            -- Actions
            map({"n", "v"}, "<leader>gs", gs.stage_hunk, { desc = "Gitsigns [S]tage Hunk" })
            map({"n", "v"}, "<leader>gr", gs.reset_hunk, { desc = "Gitsigns [R]eset Hunk" })
            map("n", "<leader>gS", gs.stage_buffer, { desc = "Gitsigns [S]tage Buffer" })
            map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Gitsigns [U]ndo Stage Hunk" })
            map("n", "<leader>gR", gs.reset_buffer, { desc = "Gitsigns [R]eset Buffer" })
            map("n", "<leader>gp", gs.preview_hunk, { desc = "Gitsigns [P]review Hunk" })
            map("n", "<leader>gb", function() gs.blame_line{full=true} end, { desc = "Gitsigns [B]lame Hunk" })
            map("n", "<leader>g=", gs.diffthis, { desc = "Gitsigns [D]iff this File" })
            map("n", "<leader>gd", function() gs.diffthis("~") end, { desc = "Gitsigns [D]iff This" })
            map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Gitsigns [T]oggle [B]lame Line" })
            map("n", "<leader>gT", gs.toggle_deleted, { desc = "Gitsigns [T]oggle [D]eleted" })

            -- Text object
            map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")

			-- Fugitive
			map("n", "<leader>g-", vim.cmd.Git, {desc = "[G]it"})

			local bufnr = vim.api.nvim_get_current_buf()
			map("n", "<leader>gp", function() vim.cmd.Git('push') end,
				{buffer = bufnr, remap = false, desc = "[G]it [p]ush"})

			-- rebase always
			map("n", "<leader>gP", function() vim.cmd.Git({'pull',  '--rebase'}) end,
				{buffer = bufnr, remap = false, desc = "[G]it [P]ull Rebase"})

			map("n", "<leader>gt", "<cmd>Git push -u origin <CR>",
				{buffer = bufnr, remap = false, desc = "[G]it Branch Push [T]rack"})
			map("n", "<leader>gh", "<cmd>diffget 2<CR>", {desc = "[G]it Select Left"})
			map("n", "<leader>gl", "<cmd>diffget 3<CR>", {desc = "[G]it Select Right"})
        end

    }

	local ok, gs = pcall(require, "gitsigns")
	gs.setup(options)
	if not ok then
        vim.notify("editor.gitsigns not loaded", vim.log.levels.WARN, { title = "editor.gitsigns" })
    end

end

return M
