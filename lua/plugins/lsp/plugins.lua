-- ~/.config/nvim/lua/plugins/lsp/plugins.lua
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
				}, -- add more servers here
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						javascript = { "prettier" },
						typescript = { "prettier" },
						html = { "prettier" },
						css = { "prettier" },
						json = { "prettier" },
						python = { "black" },
					},
					format_on_save = {
						lsp_fallback = true,
						timeout_ms = 500,
					},
				})
			end,
		},
	},
	-- Diagnostics (linting)
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "flake8" },
				lua = { "luacheck" },
			}

			-- Run linting on save
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
