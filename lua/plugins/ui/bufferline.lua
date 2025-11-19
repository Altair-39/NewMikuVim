-- lua/plugins/ui/bufferline.lua
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "none",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					offsets = { { filetype = "NvimTree", text = "Explorer", padding = 1 } },
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "slant",
					always_show_bufferline = true,
				},
			})
		end,
	},
}
