vim.opt_local.commentstring = "-- %s"

local cmp = require "cmp"

cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})
