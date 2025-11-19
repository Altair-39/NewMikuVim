-- ~/.config/nvim/lua/plugins/lsp/languages/python.lua
local on_attach = require("plugins.lsp.on-attach")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("pylsp", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },

	settings = {
		pylsp = {
			configurationSources = { "flake8" },
			plugins = {
				pyflakes = { enabled = true },
				pycodestyle = { enabled = true, maxLineLength = 88 },
				pylsp_mypy = { enabled = false },
				pylsp_black = { enabled = true },
				pylsp_isort = { enabled = true },
				pylint = { enabled = false },
			},
		},
	},
})
