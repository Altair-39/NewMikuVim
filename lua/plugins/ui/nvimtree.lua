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
			})
		end,
	},
}
