-- ~/.config/nvim/lua/plugins/ui/oil.lua
return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				-- Optional configuration
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
				},
			})

			-- Set keymaps (optional but recommended)
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })
		end,
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
		-- No opts or config needed! Works automatically
	},
}
