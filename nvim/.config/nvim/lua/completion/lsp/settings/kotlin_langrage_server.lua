local M = {}

local util = require 'lspconfig.util'
local root_files = {
  'settings.gradle', -- Gradle (multi-project)
  'settings.gradle.kts', -- Gradle (multi-project)
  'build.xml', -- Ant
  'pom.xml', -- Maven
}

local fallback_root_files = {
  'build.gradle', -- Gradle
  'build.gradle.kts', -- Gradle
}

M.root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(unpack(fallback_root_files))(fname)
    end

M.filetypes = { 'kotlin' }

M.cmd = { 'kotlin-language-server' }

return M
