vim.cmd "set syntax=off"

local backupdir = vim.fn.stdpath("data") .. "/backup"   -- setup backupdir to default neovim folder
if vim.fn.empty(vim.fn.glob(backupdir)) > 0 then
	os.execute("mkdir " .. backupdir)
end
vim.opt.backupdir = backupdir

local undodir = vim.fn.stdpath("data") .. "/undo"       -- set an undo directory "data" or "cache"
if vim.fn.empty(vim.fn.glob(undodir)) > 0 then
	os.execute("mkdir " .. undodir)
end
vim.opt.undodir = undodir

local tabspace = 4                            	-- space width for tabulation

vim.opt.backup = false                          -- creates a backup file
vim.opt.backspace = "indent,eol,start"
vim.opt.bg = "dark"                             -- base colorbackground
vim.opt.binary = true                           -- file encoding binary
vim.opt.bomb = true                             -- file encoding ucs-bom
-- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "120"                     -- fix indentline for now
vim.opt.compatible = false                      -- not vi retro-compatible
vim.opt.completeopt = "menu,menuone,noselect"    -- completion popup and displays
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.errorbells = false                      -- no bells
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.fileencodings = "utf-8"
vim.opt.fileformat = "unix"                     -- set to the only compatible one
vim.opt.fillchars = { fold = " " }              -- remove folding chars
-- vim.opt.fillchars = "vert:┃"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 10                          -- don't close any folds by default
-- vim.opt.foldmethod = "manual"
vim.opt.formatoptions:remove("croj")            -- "cro" auto-wrap CR and comment "j" join comment lines
vim.opt.grepprg = 'rg --smart-case --color=never --no-heading -H -n --column' -- better grep with rg
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.hidden = true                         	-- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                         -- highlight all search matches
vim.opt.ignorecase = true                       -- ignore case in search patterns (needed for smartcase to work)
vim.opt.inccommand = "split"                    -- shows the effects of :s as you type.
vim.opt.incsearch = true                        -- highlight all search matches while typing /
vim.opt.lazyredraw = true                       -- don't redraw window while executing macros
vim.opt.linebreak = true                        -- break display vim line
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.number = true                           -- set numbered lines
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.pyxversion = 3                          -- python builtin version
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.regexpengine = 0                        -- set regex engine
vim.opt.number = true                           -- set numbered lines
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.shiftwidth = tabspace                   -- the number of spaces inserted for each indentation
vim.opt.shortmess = "atToOc"                    -- prompt footbar abbrev.
vim.opt.showcmd = true                          -- display (partial) cmd and selection size in prompt -- set to false if slow
vim.opt.showmode = false     	                -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.sidescrolloff = 8                       -- minimal number of screen lines to keep left and right of the cursor.
vim.opt.signcolumn = "yes"                 -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true                        -- overrides ignorecase (does not work for '*', '#')
vim.opt.smartindent = false                     -- make indenting smarter again
vim.opt.softtabstop = tabspace                  -- editing tab local buffer
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.startofline = false                     -- moves cursor to non-blank char while moving between lines
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.tabstop = tabspace                      -- insert 4 spaces for a tab
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.o.timeout = true
vim.opt.timeoutlen = 500                        -- time [ms] to wait for a mapped sequence to complete -- might break plugins
vim.opt.title = true                            -- set the title of window to the value of the titlestring
vim.opt.undofile = true                         -- enable persist undo
vim.opt.undolevels = 100                         -- keep # registers per file
vim.opt.updatetime = 100              	        -- update to swap file [ms]
vim.opt.visualbell = false                      -- no visual bell
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"                     -- set * to select in "pum" popup, "tagfile" tags
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.laststatus = 3                          -- global statusline to last window
vim.opt.iskeyword:append "-,_"                  -- used in searching and recognizing with many commands
vim.opt.whichwrap:append "<,>,[,],h,l"          -- let movement keys reach the previous line

vim.opt.wildignore = {
	'*.o',
	'*.obj,*~',
	'*.git*',
	'*.meteor*',
	'*vim/backups*',
	'*sass-cache*',
	'*mypy_cache*',
	'*__pycache__*',
	'*cache*',
	'*logs*',
	'*node_modules*',
	'**/node_modules/**',
	'*DS_Store*',
	'*.gem',
	'log/**',
	'tmp/**',
	'*package-lock.json*',
	'**/dist/**',
	'**/.next/**',
	'**/.nx/**',
}

vim.g.loaded_perl_provider = 0               -- disable language support
-- vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = "python3"
vim.g.python_host_prog = "python2"

-- vim.filetype.add {
-- 	extension = {
-- 		["*.pc"] = "csh",
-- 		["*.pc.in"] = "csh",
-- 		["*.dsl"] = "groovy",
-- 	},
-- 	pattern = {
-- 		[".clang*"] = "yaml",
-- 		["Jenkinsfile"] = "groovy",
-- 	},
-- }

-- Spell check
vim.g.loaded_spellfile_plugin = 1               -- Do not use ssl vim server for dicts
