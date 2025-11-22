return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	modes = {
		test = {
			mode = "diagnostics",
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.3,
			},
		},
	},
}
