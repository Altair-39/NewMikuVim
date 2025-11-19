-- ~/.config/nvim/lua/plugins/lsp/languages/cpp.lua
local on_attach = require("plugins.lsp.on-attach")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "clangd", "--background-index" }, -- optional extra flags
	filetypes = { "c", "cpp", "objc", "objcpp" },
})
