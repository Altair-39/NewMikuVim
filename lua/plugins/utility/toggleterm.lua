-- lua/plugins/utility/toggleterm.lua
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<C-x>]], -- Ctrl+x to toggle terminal
			direction = "float",
			close_on_exit = true,
			persist_size = true,
			float_opts = {
				border = "double",
			},
		},
	},
}
