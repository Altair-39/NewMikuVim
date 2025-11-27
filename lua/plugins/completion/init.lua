return {
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",

		opts = {
			keymap = {
				preset = "enter",

				-- Use blink.cmp's built-in commands for Tab behavior
				["<Tab>"] = {
					"insert_next", -- Insert next suggestion when completion is active
					"fallback", -- Fall back to normal Tab behavior otherwise
				},

				["<S-Tab>"] = {
					"insert_prev", -- Insert previous suggestion when completion is active
					"fallback", -- Fall back to normal Shift-Tab behavior otherwise
				},
			},

			-- Your existing appearance and completion settings
			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				menu = {
					border = "double",
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("mini.icons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("mini.icons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
				documentation = { auto_show = true, window = { border = "double" } },
			},

			signature = {
				enabled = true,
				window = { border = "single" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
