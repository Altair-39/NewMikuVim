-- lua/plugins/ui/barbar.lua
return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		-- Enable animations
		animation = true,

		-- Enable auto-hiding (optional)
		auto_hide = false,

		-- Enable clickable tabs
		clickable = true,

		icons = {
			buffer_index = false,
			buffer_number = false,
			button = "",

			-- Fixed diagnostics configuration
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
				[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
				[vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
				[vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
			},

			-- Git signs configuration
			gitsigns = {
				enabled = true, -- This was missing!
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},

			filetype = {
				custom_colors = false,
				enabled = true,
			},
			separator = { left = "▎", right = "" },
			separator_at_end = true,
			modified = { button = "●" },
			pinned = { button = "", filename = true },
			preset = "default",
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = "×" },
			visible = { modified = { buffer_number = false } },
		},
	},
	version = "^1.0.0",
}
