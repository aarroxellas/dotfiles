local M = {}

M.root_files = {
	"settings.gradle", -- Gradle (multi-project)
	"settings.gradle.kts", -- Gradle (multi-project)
	"gradlew", -- Gradle binary
	"build.xml", -- Ant
	"pom.xml", -- Maven
}

M.fallback_root_files = {
	"build.gradle", -- Gradle
	"build.gradle.kts", -- Gradle
	".git",
}

M.filetypes = { "kotlin" }

M.cmd = { "kotlin-language-server" }

return M
