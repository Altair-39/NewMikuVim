return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim", -- Make sure telescope is installed
	},
	config = function()
		local harpoon = require("harpoon")

		-- Basic setup
		harpoon:setup()

		-- Telescope extension setup
		require("telescope").load_extension("harpoon")

		-- Optional: Configure telescope theme for harpoon
		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				harpoon = {
					-- You can customize the telescope theme for harpoon here
					theme = "dropdown",
					-- Other telescope options specific to harpoon
				},
			},
		})
	end,
}
