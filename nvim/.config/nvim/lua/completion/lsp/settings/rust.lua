local M = {}

local util = require 'lspconfig.util'
local root_files = {
  'Cargo.toml',
  'Cargo.lock',
}

local fallback_root_files = {
  '.git',
}

M.root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(unpack(fallback_root_files))(fname)
    end

M.filetypes = { 'rust' }

M.cmd = { 'rust-analyzer' }

M.tools = {
	runnables = {
	  use_telescope = true,
	},
	inlay_hints = {
	  auto = true,
	  show_parameter_hints = false,
	  parameter_hints_prefix = "",
	  other_hints_prefix = "",
	},
}

return M
