-- ~/.config/nvim/lua/plugins/ui/nvimtree.lua
return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				sort_by = "name",
				view = { width = 30, side = "left" },
				renderer = { highlight_git = true },
				filters = { dotfiles = false },
				diagnostics = {
					enable = true,
					show_on_dirs = true, -- Show diagnostics on directories too
					show_on_open_dirs = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
			})
		end,
	},
}
