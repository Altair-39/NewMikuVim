return {
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("barbecue").setup()
	end,
}
