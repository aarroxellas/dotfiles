local opt = vim.opt
--------------- dirs | files ---------------
--------------------------------------------

local backupdir = vim.fn.stdpath("data") .. "/backup"   -- setup backupdir to default neovim folder
if vim.fn.empty(vim.fn.glob(backupdir)) > 0 then
	os.execute("mkdir " .. backupdir)
end
opt.backupdir = backupdir
opt.backup = false                          -- creates a backup file
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

local undodir = vim.fn.stdpath("data") .. "/undo"       -- set an undo directory "data" or "cache"
if vim.fn.empty(vim.fn.glob(undodir)) > 0 then
	os.execute("mkdir " .. undodir)
end
opt.undodir = undodir
opt.undofile = true                         -- enable persist undo
opt.undolevels = 100                        -- keep # registers per file

opt.swapfile = false                        -- creates a swapfile
opt.updatetime = 100              	        -- update to swap file [ms]

------------------- opts -------------------
--------------------------------------------

local tabspace = 4                         	-- space width for tabulation
opt.shiftwidth = tabspace                   -- the number of spaces inserted for each indentation
opt.softtabstop = tabspace                  -- editing tab local buffer
opt.tabstop = tabspace                      -- insert 4 spaces for a tab

opt.bg = "dark"                             -- base colorbackground
opt.binary = true                           -- file encoding binary
opt.bomb = true                             -- file encoding ucs-bom
opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
opt.colorcolumn = "120"                     -- fix indentline for now
opt.compatible = false                      -- not vi retro-compatible
opt.completeopt = "menu,menuone,noselect"    -- completion popup and displays
opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.cursorline = true                       -- highlight the current line
opt.encoding = "utf-8"
opt.expandtab = false                       -- convert tabs to spaces
opt.errorbells = false                      -- no bells
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.fileencodings = "utf-8"
opt.fileformat = "unix"                     -- set to the only compatible one
opt.fillchars = { fold = " " }              -- remove folding chars
-- opt.fillchars = "vert:┃"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 10                          -- don't close any folds by default
-- opt.foldmethod = "manual"
opt.formatoptions:remove("croj")            -- "cro" auto-wrap CR and comment "j" join comment lines
opt.grepprg = 'rg --smart-case --color=never --no-heading -H -n --column' -- better grep with rg
opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
opt.hidden = true                         	-- required to keep multiple buffers and open multiple buffers
opt.hlsearch = true                         -- highlight all search matches
opt.ignorecase = true                       -- ignore case in search patterns (needed for smartcase to work)
opt.inccommand = "split"                    -- shows the effects of :s as you type.
-- opt.incsearch = true                        -- highlight all search matches while typing /
opt.laststatus = 3                          -- global statusline to last window
opt.lazyredraw = true                       -- don't redraw window while executing macros
opt.linebreak = true                        -- break display vim line
opt.mouse = "a"                             -- allow the mouse to be used in neovim
opt.number = true                           -- set numbered lines
opt.pyxversion = 3                          -- python builtin version
opt.relativenumber = true                   -- set relative numbered lines
opt.regexpengine = 0                        -- set regex engine
opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
opt.showcmd = true                          -- display (partial) cmd and selection size in prompt -- set to false if slow
opt.showmode = false     	                -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0                         -- show files in tabs | 0 desable
opt.sidescrolloff = 8                       -- minimal number of screen lines to keep left and right of the cursor.
opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
opt.shada = { "'10", "<0", "s10", "h" }
opt.smartcase = true                        -- overrides ignorecase (does not work for '*', '#')
opt.smartindent = false                     -- make indenting smarter again
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.startofline = false                     -- moves cursor to non-blank char while moving between lines
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.timeout = true
opt.timeoutlen = 500                        -- time [ms] to wait for a mapped sequence to complete -- might break plugins
opt.title = true                            -- set the title of window to the value of the titlestring
opt.wildmenu = true
opt.wildmode = "full"
opt.wildoptions = "pum"                     -- set * to select in "pum" popup, "tagfile" tags
opt.pumblend = 10							-- pop up menu transparancy
opt.pumheight = 10                          -- pop up menu height
opt.wrap = false                            -- display lines as one long line
opt.visualbell = false                      -- no visual bell
opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
opt.backspace = "indent,eol,start"
opt.iskeyword:append "-,_"                  -- used in searching and recognizing with many commands
opt.whichwrap:append "<,>,[,],h,l"          -- let movement keys reach the previous line
opt.shortmess = "atToOc"                    -- prompt footbar abbrev.
opt.formatoptions:remove "o,O"              -- do not comment at 'o,O' -- works ?

opt.wildignore = {
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

vim.g.loaded_netrw_banner = 0
vim.g.loaded_netrw_mouse = 2
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
