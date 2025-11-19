-- lua/plugins/utility/autopairs.lua
return {
	{
		"windwp/nvim-autopairs",
		lazy = false, -- load immediately
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				fast_wrap = { map = "<M-e>" },
			})

			-- CMP integration (optional)
			local status_ok, cmp = pcall(require, "cmp")
			if status_ok then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename paired tags
					enable_close_on_slash = false, -- Auto close on </
				},
			})
		end,
	},
}
