local on_attach = require("plugins.lsp.on-attach")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("texlab", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = true, -- auto build on save
			},
			forwardSearch = {
				executable = "zathura", -- change if you use okular/skim/etc
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
			lint = {
				onChange = true,
			},
		},
	},
})
