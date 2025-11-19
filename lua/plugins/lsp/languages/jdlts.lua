return {
	"nvim-java/nvim-java",
	config = false,
}, {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	config = function()
		local jdtls_ok, jdtls = pcall(require, "jdtls")
		if not jdtls_ok then
			vim.notify("JDTLS not found", vim.log.levels.ERROR)
			return
		end

		local home = os.getenv("HOME")
		local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = workspace_path .. project_name

		-- 🔹 Detect correct platform dir
		local config_path = home .. "/.local/share/nvim/mason/packages/jdtls/"
		local os_config = ({
			Linux = "config_linux",
			Darwin = "config_mac",
			Windows = "config_win",
		})[vim.loop.os_uname().sysname] or "config_linux"

		-- 🔹 Launcher .jar file (must be globbed)
		local launcher_path = vim.fn.glob(config_path .. "plugins/org.eclipse.equinox.launcher_*.jar")
		if launcher_path == "" then
			vim.notify("JDTLS launcher jar not found!", vim.log.levels.ERROR)
			return
		end

		local config = {
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-javaagent:" .. config_path .. "lombok.jar",
				"-jar",
				launcher_path,
				"-configuration",
				config_path .. os_config,
				"-data",
				workspace_dir,
			},

			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml",
				"build.gradle" }),

			settings = {
				java = {
					signatureHelp = { enabled = true },
					maven = { downloadSources = true },
					referencesCodeLens = { enabled = true },
					references = { includeDecompiledSources = true },
					inlayHints = { parameterNames = { enabled = "all" } },
					format = { enabled = true }, -- enable formatting if you want
				},
			},

			init_options = { bundles = {} },
		}

		-- Start or attach jdtls
		jdtls.start_or_attach(config)

		-- 🔹 Keymaps (example)
		local opts = { silent = true, buffer = 0 }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
}
