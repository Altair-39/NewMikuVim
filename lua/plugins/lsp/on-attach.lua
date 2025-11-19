-- ~/.config/nvim/lua/plugins/lsp/on-attach.lua
local M = {}

M.on_attach = function(client, bufnr)
	local map = vim.keymap.set
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- =====================
	-- LSP keymaps
	-- =====================
	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- =====================
	-- Autoformat on save
	-- =====================
	if client.server_capabilities.documentFormattingProvider then
		-- Create a dedicated augroup per buffer
		local group_name = "LspFormat" .. bufnr
		local group = vim.api.nvim_create_augroup(group_name, { clear = true })

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

return M.on_attach
