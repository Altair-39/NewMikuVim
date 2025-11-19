-- lua/plugins/ui/noice.lua
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true, -- Automatically show signature help when typing trigger characters
						luasnip = true,
						throttle = 50,
					},
					view = nil, -- Use the default view
					opts = {}, -- Default options
				},
				hover = {
					enabled = true,
					view = nil, -- Use the default view
					opts = {}, -- Default options
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
