local M = {}

M.settings = {}

M.root_files = {
	"gradlew", -- Gradle binary
	"mvnw", -- Mvn binary
	"build.xml", -- Ant
	"pom.xml", -- Maven
}

M.fallback_root_files = {
	-- "build.gradle", -- Gradle
	-- "build.gradle.kts", -- Gradle
	".git",
	"settings.gradle", -- Gradle (multi-project)
	"settings.gradle.kts", -- Gradle (multi-project)
}

M.filetypes = { "kotlin" }

M.cmd = { "kotlin-language-server" }

return M
